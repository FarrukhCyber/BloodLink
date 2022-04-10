const express = require('express')
const app = express()
const port = 8080 || process.env.Port
const mongoose = require('mongoose')
const User = require('./models/user_model')
const auth = require('./routes/auth.js')

app.use(express.json({extended:false})) // will allow us to read json 

dbConnect = async () => {
    await mongoose.connect("mongodb+srv://shaddahmed:shaddahmed@cluster0.mcgyr.mongodb.net/bloodlink?retryWrites=true&w=majority",
    {useNewUrlParser:true, useUnifiedTopology:true})
    console.log("DB connected")
}

dbConnect()


app.get('/', (req, res) => {
    res.send("Hello World")
})

app.use('/auth', auth)

app.listen(port, () => console.log("Listening on Port:", port))