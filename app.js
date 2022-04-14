const mongoose = require("mongoose")
const express = require('express')
const port = process.env.Port || 8080  
const app = express()
//const submitRequestRoutes = require('./src/routes/submitRequestRoutes')
const registerAsDonor = require('./src/routes/registerAsDonor')
const myRequests = require('./src/routes/myRequests')
const User = require('./src/models/user_model')
const auth = require('./src/routes/auth.js')

app.use(express.json({extended:false}))

app.listen(port, () => console.log("Listening on Port:", port))

//DB Connection-----------
// dbConnect = async () => {
//     try {
//         //await mongoose.connect("mongodb://localhost:27017/myapp",
//         await mongoose.connect("mongodb+srv://dbAdmin:9GRY24WWlW6lRwjS@cluster0.t0zsi.mongodb.net/BloodLink?retryWrites=true&w=majority",
//         {useNewUrlParser:true, useUnifiedTopology:true})
//         console.log("DB connected")
//     }
//     catch(err) {
//         console.log(`${err} Ocurred while connecting to DB`)
//     }
// }

// dbConnect()
//-------------------------


app.get('/', (req, res) => {
    res.send("Hello World")
})

app.use('/auth', auth)
app.use("/register_donor", registerAsDonor)
app.use("/my_requests", myRequests)
// 404 page
app.use((req, res) => {
    res.status(404).render('404', { title: '404' });
  });