const express = require('express')
const router = express.Router()
const RequestModel = require('../models/bloodRequest')

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
        post: `Blood Type: ${result.blood_group} Hospital: ${result.hospital} Contact: ${result.attendant_num}` ,
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
        hospital : result.hospital
    })

    blood_req.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
    res.json({key: "success"})

}

router.post("/" , (req, res) => {
    console.log(req.body.attendant_name)
    const result = req.body
    // saveToDb(result)

    const socialMediaPosting = async () => {
        const content = getPostData(result)
        const json = await social.post(content).catch(console.error)
        console.log(json)
    }

    // socialMediaPosting()
    sendEmails()
})

module.exports = router