const express = require('express');
const router = express.Router();
const User = require('../models/user_model')


router.get("/", (req, res) => {
    User.findOne({userName: "daimakram"} , (err, user) => {
        if(err) {
            console.log(`${err} while fetching from users`)
            res.json({msg: "ERROR"})
        }
        else {
            res.json({info: user})
        }
    })
})

module.exports = router