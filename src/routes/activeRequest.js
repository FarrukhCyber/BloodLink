const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").get((req, res) => {
  console.log("hii")
  console.log("hi")
    Request.find({ status : false}, (err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else {
        console.log(result)
        return res.json({ data: result });}
    });
  });

  module.exports = router
