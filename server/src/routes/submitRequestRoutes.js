const express = require('express')
const router = express.Router()

const RequestModel = require('../models/bloodRequest')
const RegUserModel = require("../models/registeredUsers")
const DonorsModel = require("../models/donors")

const {ONE_SIGNAL_CONFIG} = require("../config/notifications_config")
const pushNotificationService = require("../services/push_notification_service")


//Social post handling
const socialPost = new require('social-post-api')
const social = new socialPost("TRSHJM6-NQK4KXQ-KT57N53-0BGWNBP")

//Email handling
const nodemailer = require('nodemailer')
let mailTransporter = nodemailer.createTransport({
    service: "outlook365",
    user: "bloodlink.lcss@outlook.com",
    pass: "bloodlink@SEproject"
})


function sendEmails() {
    let emailDetails = {
        from: "bloodlink.lcss@outlook.com",
        to : "muhammadfarrukh2001@gmail.com",
        subject: "Test Email",
        text: "hello g"
    }
    
    mailTransporter.sendMail(emailDetails, (err, info) => {
        if (err) {
            console.log(`${err} occurred while sending email`)
        }
        else {
            console.log("Email Sent:", info.response )
        }
    } )

}


const getPostData = (result) => {
    return {
        post: `Blood Type: ${result.blood_group} \n Hospital: ${result.hospital} \nContact: ${result.attendant_num}` ,
        platforms: ["facebook"]
    }
}


function saveToDb(result) {
    //Storing the data in db
    const blood_req = new RequestModel({
        req_id: result.req_id ,
        attendant_name: result.attendant_name,
        attendant_num: result.attendant_num ,
        blood_group: result.blood_group ,
        status: result.status,
        quantity: result.quantity,
        user_contact_num: result.user_contact_num,
        admin_id: result.admin_id ,
        moderator_id: result.moderator_id ,
        deadline: result.deadline,
        hospital : result.hospital,
        city: result.city
    })

    blood_req.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
    res.json({key: "success"})

}

const socialMediaPosting = async (result) => {
    const content = getPostData(result)
    const json = await social.post(content).catch(console.error)
    console.log(json)
}

const sendNotificationToDevice = (devices, res, next, msg) => {
    var message = {
        app_id: ONE_SIGNAL_CONFIG.APP_ID,
        contents: {'en' : msg},
        included_segments: ["included_player_ids"], 
        include_player_ids: devices, 
        content_available: true,
        small_icon: "ic_notification_icon",
        data: {
            PushTitle: "Custom Notification"
        }
    }

    pushNotificationService.sendNotification(message, (err, results) => {
        if(err) {
            return next(err)
        }

        return res.status(200).send({
            message: "Success",
            data: results
        })
    })
}

router.post("/" , (req, res, next) => {
    const result = req.body

    // saveToDb(result)
    // socialMediaPosting(result)
    // sendEmails()
    handleNotifications(req, res, next, result)
})

module.exports = router

const handleNotifications =  async (req, res, next, result) => {
    //get those donors who are from required city and required blood_group
    let docs
    try {
        docs = await DonorsModel.find({city: result.city, blood_group: result.blood_group})
        console.log(docs)
    }
    catch(err) {
        console.log(err + "while querying to donors")
    }

    let devices = []
    for (const object of docs) {
        try {
            const id = await RegUserModel.findOne({user_contact_num: object.user_contact_num})
            console.log(id)
            devices.push(id.notification_id)
        }
        catch(err) {
            console.log(err + "while querying registered users")
        }
    }

    let message = `${result.blood_group} blood is required at ${result.hospital} in ${result.city}`

    sendNotificationToDevice(devices, res, next, message)

}

/*
{
    "req_id": 1,
    "attendant_name": "farrukh",
    "attendant_num": "03364984545",
    "blood_group": "O-",
    "status": false,
    "quantity": "500ml",
    "user_contact_num": "03364984545",
    "admin_id": 1,
    "moderator_id": 2,
    "deadline": "2022-04-08",
    "hospital" : "Jinnah"
}
*/