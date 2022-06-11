const express = require('express')
const router = express.Router()
const DonorsModel = require('../models/donors')
const User = require('../models/user_model')


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
    })

    // User.findOne({phoneNumber: result.user_contact_num}, (err,user)=>{
    //     if(err)
    //     {
    //         console.log("err", err);
    //     }
    //     else
    //     {
    //         console.log("previously");
    //         console.log(user);
    //     }
    // })
    User.findOneAndUpdate({phoneNumber: result.user_contact_num} , {donor: true} ,(err, user)=>{
        if(err){
            console.log("Could not find the User.", err)
            // res.json({msg: "ERROR"})
        }})

    
    // console.log("Updated " , user);

    donor_register.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
    res.json({key: "success"})

}

router.post("/" , (req,res) => {
    console.log(req.body.attendant_name)
    const result = req.body
    console.log("in register as Donor")
    saveToDb(result,res)
})

module.exports = router