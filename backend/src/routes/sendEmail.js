const express = require('express')
const router = express.Router()
const sendEmail = require('../services/email_service')
const Request = require('../models/bloodRequest')
const RegUserModel = require("../models/user_model")


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

router.route("/").post((req, res) => {
    // console.log("in rejected")
      console.log(req.body.id)
    //   Request.findById(req.body.id, (err,userSol) => {
    //     console.log("Found it\n", userSol)
    //   })
    const result = req.body
    console.log(result)
    handleEmail(result); 
    Request.findById(req.body.id , (err,doc) => {
        console.log("I found :"  , doc)
    })
    Request.findByIdAndUpdate(req.body.id, {email:"3"}, (err,doc) => {
        if(err){
            console.log("Error")
            res.json({msg: "null"})
        }
        else{
            console.log("done")
            res.json({msg:"done"})
        }
    }) }) 
  

module.exports = router

