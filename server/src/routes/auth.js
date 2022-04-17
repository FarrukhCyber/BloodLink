const express = require('express');
const router = express.Router();
const User = require('../models/user_model')


router.get('/login', (req,res)=>{
    res.send("In login auth")
})

router.route("/phone").get((req, res) => {
    console.log("hi")
      User.findOne({ phoneNumber : req.headers.user_contact_num}, (err, result) => {
        if (err) return res.json({ msg: "ERROR" });
        if (result == null) return res.json({msg:"null"});
        else {
          console.log(result)
          return res.json({ msg:"exists" });}
      });
    });

router.post('/login', (req, res) => {
    console.log("IN LOGIN -- AUTH")
    const {userName, password, phoneNumber} = req.body
    console.log(userName, password, phoneNumber)
    // res.json({msg:"success"})
    User.findOne({phoneNumber: req.body.phoneNumber, password:req.body.password}, (err, user)=>{
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
                if(user.userName=="ADMIN" && user.phoneNumber=="923187007636")
                {
                res.json({msg:"ADMIN MODE", 
                    userName: user.userName,
                    phoneNumber:String(user.phoneNumber)})
                }
                else{
                res.json({msg:"Login Successful", 
                    userName: user.userName,
                    email:user.email,
                    password:user.password,
                    gender:user.gender,
                    bloodType:user.bloodType,
                    age:String(user.age),
                    phoneNumber:String(user.phoneNumber)})
                }
            }
        }
    })
    // return res.send("In Login")
    console.log("IN Login")
})
router.post('/signup', (req, res) => {
    console.log("IN SIGNUP -- AUTH")
    const {userName, password, phoneNumber, bloodType, email, gender, age} = req.body
    console.log(userName, "|", email, "|", password, "|", phoneNumber, "|", bloodType, "|", gender, "|", age)
    if(!userName || !password || !phoneNumber || !bloodType || !email || !age || !gender)
        {console.log("null values")
        res.json({signup:"null values"})}
    else{
        dob = age.split(" ")[0]
        console.log("Age/DOB: ", typeof(age), dob)
        // res.json({msg:"success"})
        // ensures username and email are unique 
        User.findOne({email:email}, (err, user)=>{
        if(err){
            console.log("err: ", err)
            res.json({signup: "ERR"}) // please try again 
        }
        else{
            if(user==null) // if email exists 
            {
                User.findOne({userName:userName}, (err, user)=>{
                    if(err){
                        console.log("err: ", err)
                        res.json({signup: "ERR"}) // please try again 
                    }
                    else{ 
                        if(user==null){
                        console.log("user is new ", user)
                        var tempUser = new User({
                            userName:userName,
                            password:password,
                            bloodType:bloodType,
                            phoneNumber:Number(phoneNumber),
                            email:email,
                            gender:gender,
                            age:dob
                        })
                    console.log(tempUser)
                    tempUser.save((err,doc)=>{
                        if(!err) res.json({signup: "Signup Successful",
                        })
                        else console.log("there was erorr", err)})}
                        else{
                        console.log("Sending user exists", user.email)
                        res.json({signup: "Username exists"})                        
                    }
                }})
            }
            else {
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
