const express = require('express');
const router = express.Router();
const Donor = require('../models/donors')

router.route("/").get((req, res) => {
    console.log("hi")
      Donor.findOne({ user_contact_num : req.headers.user_contact_num}, (err, result) => {
        if (err) return res.json({ msg: "error" });
        if (result == null) return res.json({msg:"unique"});
        else {
          console.log(result)
          return res.json({ msg:"exists" });}
      });
    });

    module.exports = router
