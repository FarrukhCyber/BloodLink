const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").get((req, res) => {
  console.log("fetching active req data")
    Request.find({ status : true}, (err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else {
        console.log(result)
        return res.json({ data: result });}
    });
  });

  module.exports = router