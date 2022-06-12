const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/rej").post((req, res) => {
  console.log("in rejected")
    console.log(req.body.id)
    Request.findById(req.body.id, (err,userSol) => {
      console.log("Found it\n", userSol)
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
    }) 

    // Request.findOneAndUpdate({_id: req.body.id} , {email : "3"} ,(err, userSol)=>{
    //   if(err){
    //       console.log("Could not find the User.", err)
    //       res.json({msg: "null"})
    //   }else{
    //     console.log("Success")
    //     res.json({msg: "done"})
    //   } })

  });

  module.exports = router