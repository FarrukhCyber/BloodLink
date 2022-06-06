const express = require('express')
const router = express.Router()

const RequestModel = require('../models/bloodRequest')
const RegUserModel = require("../models/user_model")
const DonorsModel = require("../models/donors")

const {ONE_SIGNAL_CONFIG} = require("../config/notifications_config.js")
const pushNotificationService = require("../services/push_notification_service")
//Social post handling
const socialPost = new require('social-post-api')
const social = new socialPost("TRSHJM6-NQK4KXQ-KT57N53-0BGWNBP")

//Email handling
const sendEmail = require('../services/email_service')



const getPostData = (result) => {
    return {
        post: `Blood Type: ${result.blood_group} \nHospital: ${result.hospital} \nContact: ${result.attendant_num}` ,
        platforms: ["facebook"]
    }
}


function saveToDb(result) {
    //handling time data
    let temp = result.time
    result.time = temp.substr(10,5)
    //2022-04-21T00:00:00.000+05:30
    let newDate = result.date
    result.time = newDate.replace("00:00", result.time)
    console.log(result)
    //-------------------------

    //Storing the data in db
    const blood_req = new RequestModel({
        req_id: 4 ,
        attendant_name: result.attendant_name,
        attendant_num: result.attendant_num ,
        blood_group: result.blood_group ,
        status: false,
        quantity: ('quantity' in result ? result.quantity : "500ml"),
        user_contact_num: ('user_contact_num' in result ? result.user_contact_num : "923364984545"),
        admin_id: ('admin_id' in result ? result.admin_id : null),
        moderator_id: ('moderator_id' in result ? result.moderator_id : null) ,
        date: result.date,
        time: result.time,
        hospital : result.hospital,
        city: result.city
    })

    blood_req.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
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
    console.log(result)

    // saveToDb(result)
    res.json({msg: "Request Added"})
    
    // socialMediaPosting(result)
    // handleEmail(result)
    handleNotifications(req, res, next, result)

})


const handleNotifications =  async (req, res, next, result) => {
    //get those donors who are from required city and required blood_group
    let docs
    try {
        docs = await DonorsModel.find({region: result.city, blood_group: result.blood_group})
        console.log(docs)
    }
    catch(err) {
        console.log(err + "while querying to donors")
    }

    let devices = []
    for (const object of docs) {
        try {
            const id = await RegUserModel.findOne({phoneNumber: object.user_contact_num})
            console.log(id)
            if ("deviceID" in id) {
                devices.push(id.deviceID)
            }
            // devices.push(id.deviceID)
            // devices.push(id.notification_id)
        }
        catch(err) {
            console.log(err + "while querying registered users")
        }
    }

    let message = `${result.blood_group} blood is required at ${result.hospital} in ${result.city}`

    sendNotificationToDevice(devices, res, next, message)

}

const handleEmail = async (result) => {
    let docs
    let emailList = []
    try {
        docs = await RegUserModel.find({bloodType: result.blood_group})
        // console.log(docs)
        for (const object of docs) {
            emailList.push(object.email)
        }
        console.log("Email list:", emailList)
    }
    catch(err) {
        console.log(`${err} while fetching from users`)
    }

    let body = `Dear LUMS Community, \n\nPlease find attached the details to a blood request case: \n\nBlood Group: ${result.blood_group} \nContact: ${result.attendant_num} \nHospital: ${result.hospital} \nCity: ${result.city} \n\nYour effort can help save a life. You have it in you to give! \n\nRegards, \n\nBloodLink LCSS`


    sendEmail(emailList, body)

}

module.exports = router
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
    "date": "2022-05-20T19:00:00.000+00:00",
    "time": "2022-05-20T19:05:00.000+00:00",
    "hospital" : "Jinnah",
    "city": Lahore
}
*/