const express = require('express');
const router = express.Router();
const User = require('../models/user_model')


router.post('/', (req, res) => {
    console.log("IN password change -- AUTH")
    const {password, phoneNumber} = req.body
    console.log(password, phoneNumber)
    // res.json({msg:"success"})
    User.findOneAndUpdate({phoneNumber: req.body.phoneNumber}, {password:req.body.password}, null, (err, user)=>{
        if(err){
            console.log("Sendnig", err)
            res.json({msg: "ERROR"})
        }
        else{
            if(user==null) // exists
            {
                console.log("Sending", user)
                res.json({msg:"null"})
            }
            else
            {
                console.log("exists", user)
                res.json({msg:"updated"})
            }
        }
    })
    // return res.send("In Login")
    console.log("IN Login")
})

module.exports = router