const express = require('express');
const router = express.Router();
const User = require('../models/user_model')
const Donor = require('../models/donors')


router.route("/email").post((req,res) => {
    const {phone, email} = req.body
    console.log("In Email: ", email, phone)

    User.findOne({email : email}, (err, result) => {
        console.log(result)
        if(err){
            console.log("Find.. Error \n", err)
            res.json({edit: null})
        } else if(result) {
            console.log("Exists")
            res.json({edit: "exists"})
        }
        else{
            User.findOneAndUpdate({phoneNumber : phone}, {email: email}, (err,result) => {
                if(err) {
                    consolelog("Error \n", err)
                    res.json({edit : null})}
                else{ 
                    console.log("Success\n", result)
                    res.json({edit: "done"}) }
            })
        }
    })
    
})

router.route("/password").post((req,res) => {
    const {phone, password} = req.body
    console.log("In Password: ", password, phone)
    
    User.findOneAndUpdate({phoneNumber : phone}, {password: password}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({password : null})}
        else{ 
            console.log("Success\n", result)
            res.json({password: "done"}) }
    })
})

router.route("/gender").post((req,res) => {
    const {phone, gender} = req.body
    console.log("In Gender: ", gender, phone)
    
    User.findOneAndUpdate({phoneNumber : phone}, {gender: gender}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({gender : null})}
            else{ 
                console.log("Success\n", result)
                Donor.findOneAndUpdate({user_contact_num : phone}, {gender: gender}, (err,result) => {
                    if(err){
                        consolelog("Error \n", err)
                        res.json({gender : null})}
                    else{
                        console.log("Final success\n", result)
                        res.json({gender: "done"}) 
                    }
                }) 
        }
    })
})

router.route("/blood").post((req,res) => {
    const {phone, blood} = req.body
    console.log("In Blood: ", phone, blood)
    
    User.findOneAndUpdate({phoneNumber : phone}, {bloodType: blood}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({blood : null})}
        else{ 
            console.log("Success\n", result)
            Donor.findOneAndUpdate({user_contact_num : phone}, {blood_group: blood}, (err,result) => {
                if(err){
                    consolelog("Error \n", err)
                    res.json({blood : null})}
                else{
                    console.log("Final success\n", result)
                    res.json({blood: "done"}) 
                }
            }) 
    }
})})

router.route("/name").post((req,res) => {
    const {phone, name} = req.body
    console.log("In Blood: ", phone, name)
    
    User.findOneAndUpdate({phoneNumber : phone}, {userName: name}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({name : null})}
        else{ 
            console.log("Success\n", result)
            res.json({name: "done"}) }
    })
})

router.route("/region").post((req,res) => {
    const {phone, region} = req.body
    console.log("In region: ", phone, region)
    
    Donor.findOneAndUpdate({phoneNumber : phone}, {region: region}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({region : null})}
        else{ 
            console.log("Success\n", result)
            res.json({region: "done"}) }
    })
})

router.route("/age").post((req,res) => {
    const {phone, age} = req.body
    console.log("In age: ", phone, age)

    User.findOneAndUpdate({phoneNumber : phone}, {age: age}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({ageIs : null})}
        else{ 
            console.log("Success\n", result)
            res.json({ageIs : "done"}) }
    })
})


router.route("/phone").post((req,res) => {
    const {phone, newPhone} = req.body
    console.log("In Phone: ", phone, newPhone)
    
    User.findOneAndUpdate({phoneNumber : phone}, {phoneNumber: newPhone}, (err,result) => {
        if(err) {
            consolelog("Error \n", err)
            res.json({blood : null})}
        else{ 
            console.log("Success\n", result)
            Donor.findOneAndUpdate({user_contact_num : phone}, {user_contact_num: newPhone}, (err,result) => {
                if(err){
                    consolelog("Error \n", err)
                    res.json({blood : null})}
                else{
                    console.log("Final success\n", result)
                    res.json({blood: "done"}) 
                }
            }) 
    }
})})



module.exports = router;
