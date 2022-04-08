// Just to illustrate the routing. Copy the setup code from here, when u create ur own routes
const express = require('express');
const DonorsModel = require('../models/donors');
const router = express.Router()
const RegisteredUsersModel = require('../models/registeredUsers')

console.log("I got into editAccount");
// 
router.get("/" , (req, res) => {    
    console.log("Check:", req.body.user_contact_num);
    var result 
    const getResult = async () => {
        try {
            resultRegistered = await RegisteredUsersModel.find({user_contact_num:req.body.user_contact_num});
            resultDonors = await DonorsModel.find({user_contact_num:req.body.user_contact_num});
            // console.log(resultRegistered);
            // console.log(resultDonors);
            // const userRegistered = JSON.parse(resultRegistered);
            // console.log(userRegistered)
            // var userDonors = JSON.parse(resultDonors);
            res.json(
                {
                    // registered: resultRegistered,
                    // donors: resultDonors 
                    user_name:resultRegistered[0].user_name,
                    mobile_no:resultRegistered[0].user_contact_num,
                    region:resultDonors.region, //if it gives an error contact Hassnain
                    email:resultRegistered[0].email,
                    password:resultRegistered[0].password,
                    gender:resultRegistered[0].gender,
                    blood_group:resultRegistered[0].blood_group
                }
            )
            // console.log(resultRegistered)
            // RegisteredUsersModel.find({user_contact_num:req.body.user_contact_num}).then(
            //     // console.log(resultRegistered.user_name),
            //     res.json(
            //         {
            //             registered: resultRegistered,
            //             donors: resultDonors 
            //         }
            //     )
            // )
        }
        catch(err) {
            console.log(`${err} occurred while fetching from db`)
        }
    }

    getResult()
})

module.exports = router