const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").get((req, res) => {
  console.log("hi")
  console.log("line 9");
    Request.find({ email : "2"}).sort({'_id': -1}).exec(function(err, result) { // email : 1 -> send email , 2 -> wait for admin decision , 3 -> Admin said, do not send email.
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else {
        console.log(result)
        return res.json({ data: result });}
    });
    // Request.find({ email : "2"}, (err, result) => { // email : 1 -> send email , 2 -> wait for admin decision , 3 -> Admin said, do not send email.
    //   if (err) return res.json({ err: err });
    //   if (result == null) return res.json({ data: [] });
    //   else {
    //     console.log(result)
    //     return res.json({ data: result });}
    // });
  });

  module.exports = router