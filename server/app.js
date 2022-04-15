const mongoose = require("mongoose")
const express = require('express')
const port = 8080 || process.env.Port
const app = express()
const submitRequestRoutes = require('./src/routes/submitRequestRoutes')


app.use(express.json({extended:false}))

app.listen(port, () => console.log("Listening on Port:", port))

//DB Connection-----------
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
//-------------------------


app.use("/submit_request", submitRequestRoutes)


// 404 page
app.use((req, res) => {
    res.status(404).render('404', { title: '404' });
  });