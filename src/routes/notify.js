const express = require('express')
const router = express.Router()

const RequestModel = require('../models/bloodRequest')
const RegUserModel = require("../models/user_model")

const {ONE_SIGNAL_CONFIG} = require("../config/notifications_config.js")
const pushNotificationService = require("../services/push_notification_service")

router.post("/", (req, res, next) => {
    console.log("Data:", req.body)

    result = req.body

    handleNotifications(req, res, next, result)


})

const handleNotifications =  async (req, res, next, result) => {
    devices = []
    donorUserName = ""
    try {
        docs = await RequestModel.findById(result.id) //find the contact number of the requestor
        console.log("docs:" , docs)

        ans = await RegUserModel.findOne({phoneNumber: docs.user_contact_num}) //find the device ID of the requestor
        console.log("ans:", ans)

        if ("deviceID" in ans && ans.deviceID != undefined) {
            console.log("Check deviceID:", ans.deviceID)
            devices.append(ans.deviceID)
        }

        ans2 = await RegUserModel.findOne({phoneNumber: result.user_contact_num}) // find the username of the donor
        console.log("ans2:", ans2)

        donorUserName = ans2.userName

    } catch(err) {
        console.log(err + "while querying")
    }

    // devices = ["f098c5bf-127f-4ba4-9c10-2b450c16c8bd"] //hassnain emulator
    // devices = ["72485025-35d9-497c-bc3e-4839ccba8de6"]
    // devices = ["096c6f7e-f1ec-404e-bb10-8d16274f1a7b"] // Qari Sahb's phone for testing
    msg = `${donorUserName} is interested in donating blood against your request. You can contact him at the following number: ${result.user_contact_num}`
    sendNotificationToDevice(devices,res, next, msg)

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


module.exports =  router