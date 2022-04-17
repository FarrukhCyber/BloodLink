const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").post((req, res) => {
  console.log(req.body.status)
    Request.findOneAndUpdate({ _id : req.body._id}, {status:req.body.status},null,(err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else {
        //console.log(result.body.status)
        console.log("updated");
        return res.json({ data: result });}
    });
  });

  module.exports = router