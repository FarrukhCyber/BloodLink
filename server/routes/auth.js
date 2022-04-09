const express = require('express');
const router = express.Router();
const User = require('../models/user_model')


router.get('/login', (req,res)=>{
    res.send("In login auth")
})

router.post('/login', (req, res) => {
    console.log("IN LOGIN -- AUTH")
    const {userName, password} = req.body
    console.log(userName, password)
    // res.json({msg:"success"})
    User.findOne({userName:req.body.userName, password:req.body.password}, (err, user)=>{
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
                res.json({msg:user.email, 
                    userName: user.userName,
                    email:user.email,
                    password:user.password,
                    gender:user.gender,
                    bloodType:user.bloodType,
                    age:String(user.age),
                    phoneNumber:String(user.phoneNumber)})
            }
        }
    })
    // return res.send("In Login")
    console.log("IN Login")
})
router.post('/signup', (req, res) => {
    console.log("IN SIGNUP -- AUTH")
    const {userName, password, phoneNumber, bloodType, email, gender, age} = req.body
    console.log(userName, password, phoneNumber, bloodType, email)
    if(!userName || !password || !phoneNumber || !bloodType || !email || !age || !gender)
        console.log("null values")
    else{
    // res.json({msg:"success"})
    User.findOne({email:email}, (err, user)=>{
        if(err){
            console.log("err: ", err)
            res.json({signup: "ERR"}) // please try again 
        }
        else{
            if(user==null)
            {
                console.log("user is new ", user)
                var tempUser = new User({
                    userName:userName,
                    password:password,
                    bloodType:bloodType,
                    phoneNumber:Number(phoneNumber),
                    email:email,
                    gender:gender,
                    age:Number(age)
                })
                console.log(tempUser)
                tempUser.save((err,doc)=>{
                    if(!err) res.json({signup: tempUser.email,
                    })
                    else console.log("there was erorr", err)
                })
            }else {
                console.log("Sending user exists", user.email)
                res.json({signup: "Email exists"})
            }
        }
    })}
    // return res.send("In Login")
    console.log("Signup")
})

module.exports = router;


// res.json{
//     userName:userName,
//     email:email,
//     password:password,
//     gender:gender,
//     bloodType:bloodType,
//     age:age,
//     phoneNumber:phoneNumber
// }