const mongoose = require("mongoose")
const express = require('express')
const app = express()

app.listen(3000)

const url = "mongodb+srv://dbAdmin:9GRY24WWlW6lRwjS@cluster0.t0zsi.mongodb.net/BloodLink?retryWrites=true&w=majority" 
mongoose.connect(url , { useNewUrlParser: true, useUnifiedTopology: true }).then(
    ()=> console.log("Connection Successful")
).catch( (err) => console.log(err))

const useRouter = require("./routes/demoRoutes")
app.use("/demo", useRouter)