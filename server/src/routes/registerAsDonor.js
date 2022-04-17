const express = require('express')
const router = express.Router()
const DonorsModel = require('../models/donors')



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

    donor_register.save().then( ()=> console.log("Request added successfully")).catch((err)=>console.log(`${err} occurred while saving request to db`))
    res.json({key: "success"})

}

router.post("/" , (req,res) => {
    console.log(req.body.attendant_name)
    const result = req.body
    saveToDb(result,res)
})

module.exports = router