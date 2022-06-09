// npm i --save csvtojson


const express = require('express');
const router = express.Router();
const Cat = require('../models/donorCatalouge')
const csvtojson =require("csvtojson");
const fs = require('fs')
const jsontocsv = require('json2csv')

router.get('/test', (req,res) => {
    var tempUser = new Cat({
        Name: "Name",
        Gender: "Gender",
        RollNo:	12345, 
        Blood: "A",
        Status: "Dayscholar",
        Number: 12345,
    })
    console.log(tempUser)
    tempUser.save((err,doc)=>{
    if(!err) res.send("check, should work")
    else console.log("there was erorr", err)})}
    
                            
)
//WORK:
// check video again... ensure to pre-process all files into one before working 
// remove the for each... use insert many... itll work now 
// ISSUES:
// roll_no is not all number... do i save as number or as string 
// many fields are empty, do i still add them?
// 
router.get('/sheet', (req, res) => {
    // const filePath = "E:\\University\\SE\\BloodLink\\server\\src\\routes\\file_A+.csv"
    const filePath = "E:\\University\\SE\\BloodLink\\BloodLink_Catalouge.csv"
    
    csvtojson()
    .fromFile(filePath)
    .then(csvData => {
        csvData.forEach((element) => {
            var tempUser = new Cat({
                Name: element["Name"],
                Gender: element["Gender"],
                RollNo:	element["Roll no."], 
                Blood: element["Blood Group"],
                Status: element["Status"],
                Number: element["Contact no."],
                LastContact: element["Last Donated"],
                City: element["City"]
            })
            // console.log(tempUser, "\n\n\n\n\n")
            tempUser.save((err,doc)=>{
                if(err) console.log("there was erorr", err)
                })
        })
        res.send("ok")
        console.log("Leaving")
    }, (err) => console.log(err))
})

router.post('/add', (req, res) => {
    console.log("IN add -- AddDonor")
    const { userName, roll, status, lastContact, blood, gender, phone, city } = req.body
    console.log(userName, "|", roll, "|", phone, "|", gender, "|", city, "|", status, "|", lastContact, "|", blood)
    if(!userName || !roll || !phone || !blood || !gender || !status || !city || !lastContact)
        {
            console.log("null values")
            res.json({addDonor:"null values"})
    }
    else{
        var tempUser = new Cat({
            Name: userName,
            Gender: gender,
            RollNo:	roll, 
            Blood: blood,
            Status: status,
            Number: phone,
            LastContact: lastContact,
            City: city })
            console.log(tempUser)
            tempUser.save((err,doc)=>{
            if(!err) res.json({addDonor: "Success",
            })
            else console.log("there was erorr\n\n", err)
            })
                    
        }})


router.get('/export', (req, res) => {
    console.log("Hello there")
    Cat.find((err, data) => { // returns all the documents 
        if(err) res.json({err: "Failed"})
        else {
            console.log("type: ", typeof(data[0]))
            try{
                const csvData = jsontocsv.parse(data, {fields : ["Name", "Gender", "RollNo", "Blood",  "Status", "Number", "LastContact", "City"]})
                console.log(typeof(csvData))
                // res.json({len : data.length, first : data[0], csv: csvData})
                res.json({csv: csvData})
            }
            catch(err){
                console.log(err)
            }
        }
    })
})

module.exports = router;
