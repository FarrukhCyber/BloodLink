const express = require('express')
const router = express.Router()
const DonorsModel = require('../models/donors')
const User = require("../models/user_model")


function saveToDb(result,res) {
    //Storing the data in db
    const donor_register = new DonorsModel({
        user_contact_num: result.user_contact_num,
        blood_group: result.blood_group ,
        diabetes: result.diabetes,
        blood_disease: result.blood_disease,
        vaccinated: result.vaccinated,
        last_donated: result.last_donated,
        region: result.region,
        gender : result.gender,
        plasma: result.plasma,
        available : false,
        email : true,
        notification : true
    })

    donor_register.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
    res.json({key: "success"})

}

router.post("/add" , (req,res) => {
    console.log(req.body.attendant_name)
    const result = req.body
    saveToDb(result,res)
})

router.post("/settings" , (req,res) => {
    console.log(req.body)
    const {phone, email, notification, available, vaccinated, diabetes, disease, plasma} = req.body
    if(phone == "")
        res.json({setting: "null"})
    
    DonorsModel.findOneAndUpdate({user_contact_num: phone}, {email:email, notification:notification, available:available, vaccinated : vaccinated, 
    blood_disease : disease, diabetes: diabetes, plasma : plasma}, 
        (err, response) => {
            if(err) {
                console.log("Error\n", err)
                res.json({setting:"null"})
            }
            else{
                console.log("done")
                res.json({setting:"done"})
            }
            })     
})

router.route("/fetch").get((req, res) => {
    console.log(req.headers.user_contact_num)
     DonorsModel.find({ user_contact_num : req.headers.user_contact_num}, (err, result) => {
       if (err) res.json({ fetch: null });
       if (result == null) res.json({ fetch: null });
       else {
            console.log(result)
            res.json({ fetch : "done", emailIs: result[0].email, availableIs: result[0].available, notificationIs: result[0].notification,
        vaccinatedIs : result[0].vaccinated
        , diseaseIs : result[0].blood_disease, plasmaIs : result[0].plasma, diabetesIs :result[0].diabetes});
        }
    });
  });



module.exports = router