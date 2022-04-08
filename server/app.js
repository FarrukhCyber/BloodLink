const mongoose = require("mongoose")
const express = require('express')
const app = express()
const editAccountDetails = require('./src/routes/editAccountRoutes')

app.use(express.json({extended:false})) // will allow us to read json
app.listen(4000)

dbConnect = async () => {
    try {
        await mongoose.connect("mongodb+srv://dbAdmin:9GRY24WWlW6lRwjS@cluster0.t0zsi.mongodb.net/BloodLink?retryWrites=true&w=majority",
        {useNewUrlParser:true, useUnifiedTopology:true})
        console.log("DB connected")
    }
    catch(err) {
        console.log(`${err} Ocurred while connecting to DB`)
    }
}

dbConnect()

app.use("/small", editAccountDetails)

console.log(" I am waiting down here ");