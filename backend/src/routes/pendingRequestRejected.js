const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").get((req, res) => {
  console.log("in rejected")
    Request.findOneAndUpdate({id: req.body.id} , {email : "3"},  (err,request) => {
        if(err)
        {
            res.json({msg : "null"});
            console.log("in err");
        }
        else
        {
            res.json({msg : "success"})
            console.log("in success");
        }
    }) 

  });

  module.exports = router