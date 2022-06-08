const express = require('express')
const router = express.Router()

const RequestModel = require('../models/bloodRequest')
const RegUserModel = require("../models/user_model")


router.post("/" , (req, res, next) => {
    const result = req.body
    console.log("Check:", result)
    updateDb(result, res)

})

async function updateDb(result, res) {
    //handling time data
    // let temp = result.time
    // result.time = temp.substr(10,5)
    // //2022-04-21T00:00:00.000+05:30
    // let newDate = result.date
    // result.time = newDate.replace("00:00", result.time)
    // console.log(result)
    //-------------------------

    //Check if the request being edited is of admin or not------------
    let docs
    userName = ""
    try {
        docs = await RegUserModel.findOne({phoneNumber: result.user_contact_num})
        console.log("docs:",docs)
        userName = docs.userName
    }
    catch(err) {
        console.log(err + "while querying to donors")
    }

    isAdmin = userName=="ADMIN" ? true : false

    //updating in db
    try {
        res = await RequestModel.updateOne({user_contact_num: result.user_contact_num}, {
            req_id: 4 ,
            attendant_name: result.attendant_name,
            attendant_num: result.attendant_num ,
            blood_group: result.blood_group ,
            status: true,
            quantity: ('quantity' in result ? result.quantity : "500ml"),
            user_contact_num: (!isAdmin ? result.user_contact_num : null),
            admin_id: (isAdmin ? result.user_contact_num : null),
            moderator_id: ('moderator_id' in result ? result.moderator_id : null) ,
            date: result.date,
            time: result.time,
            hospital : result.hospital,
            city: result.city
        })

        return res.acknowledged
    }
    catch(err) {
        console.log("error while updating blood request:", err)
    }
}


module.exports = router
