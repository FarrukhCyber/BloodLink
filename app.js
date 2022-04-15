const mongoose = require("mongoose")
const express = require('express')
const port = process.env.PORT || 8080  
const app = express()
//const submitRequestRoutes = require('./src/routes/submitRequestRoutes')
const registerAsDonor = require('./src/routes/registerAsDonor')
const myRequests = require('./src/routes/myRequests')
const User = require('./src/models/user_model')
const auth = require('./src/routes/auth.js')
const checkDb = require('./src/routes/checkDb')
const status = require('./src/routes/statusChange')
const donorAuth = require('./src/routes/donorAuth.js')
app.use(express.json({extended:false}))

app.listen(port, () => console.log("Listening on Port:", port))

//DB Connection-----------
dbConnect = async () => {
    try {
        //await mongoose.connect("mongodb://localhost:27017/myapp",
        await mongoose.connect("mongodb+srv://dbAdmin:9GRY24WWlW6lRwjS@cluster0.t0zsi.mongodb.net/BloodLink?retryWrites=true&w=majority",
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
    console.log("Touch")
})

//just for checking DB connection
app.use("/checkDb", checkDb)

app.use('/auth', auth)
app.use("/register_donor", registerAsDonor)
app.use("/my_requests", myRequests)
app.use('/status',status)
app.use("/donor_auth",donorAuth)
// 404 page
app.use((req, res) => {
    res.status(404).render('404', { title: '404' });
  });
