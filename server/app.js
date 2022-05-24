const mongoose = require("mongoose")
const express = require('express')
const port = 8080 || process.env.Port
const app = express()

const submitRequestRoutes = require('./src/routes/submitRequestRoutes')
const registerAsDonor = require('./src/routes/registerAsDonor')
const myRequests = require('./src/routes/myRequests')
const User = require('./src/models/user_model')
const status = require('./src/routes/statusChange')
const auth = require('./src/routes/auth.js')
const donorAuth = require('./src/routes/donorAuth.js')
const activeRequest = require('./src/routes/activeRequest.js')
const changePassword = require('./src/routes/changePassword.js')
const plasmaDonorRegister = require('./src/routes/plasmaDonorRegister.js')
const pendingRequest = require('../server/src/routes/pendingRequest')
const donorCatalouge = require("./src/routes/donorCat")

app.use(express.json({extended:false}))

app.listen(port, () => console.log("Listening on Port:", port))

//DB Connection-----------
dbConnect = async () => {
    try {
        await mongoose.connect("mongodb://localhost:27017/course_info",
        // await mongoose.connect("mongodb+srv://dbAdmin:9GRY24WWlW6lRwjS@cluster0.t0zsi.mongodb.net/BloodLink?retryWrites=true&w=majority",
        {useNewUrlParser:true, useUnifiedTopology:true})
        console.log("DB connected")
    }
    catch(err) {
        console.log(`${err} Ocurred while connecting to DB`)
    }
}

dbConnect()
//-------------------------


app.get('/', (req, res) => {
    res.send("Hello World")
})


app.use('/auth', auth)
app.use("/register_donor", registerAsDonor)
app.use("/my_requests", myRequests)
app.use('/status',status)
app.use("/donor_auth",donorAuth)
app.use("/active_request",activeRequest)
app.use("/password_change",changePassword)
app.use("/plasma_donor_register",plasmaDonorRegister)
app.use("/submit_request", submitRequestRoutes)
app.use("/pending_request", pendingRequest)
app.use("/cat", donorCatalouge)
// 404 page
app.use((req, res) => {
    res.json({ title: '404' });
  });