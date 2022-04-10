const express = require('express')
const router = express.Router()
const Request = require('../models/bloodRequest')



router.route("/").get((req, res) => {
    Request.find({ user_contact_num: req.body.user_contact_num}, (err, result) => {
      if (err) return res.json({ err: err });
      if (result == null) return res.json({ data: [] });
      else return res.json({ data: result });
    });
  });

  module.exports = router