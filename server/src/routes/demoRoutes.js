// Just to illustrate the routing. Copy the setup code from here, when u create ur own routes
const express = require('express')
const router = express.Router()

// 
router.get("/demo" , (res, req) => {
    res.send("DEMO Here")
})

module.exports = router