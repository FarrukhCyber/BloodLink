const express = require('express')
const app = express()
const port = 8080 || process.env.Port
const mongoose = require('mongoose')
const User = require('./models/user_model')

app.use(express.json({extended:false})) // will allow us to read json 

// dbConnect = async () => {
//     await mongoose.connect("mongodb+srv://shaddahmed:shaddahmed@cluster0.mcgyr.mongodb.net/Project0?retryWrites=true&w=majority",
//     {useNewUrlParser:true, useUnifiedTopology:true})
//     console.log("DB connected")
// }

// dbConnect()

app.get('/', (req, res) => {
    res.send("Hello World")
})

app.post('/login', (req, res) => {
    const {name, pass} = req.body
    console.log(name, pass)
    res.json({msg:"success"})
    // User.findOne({userName:req.body.userName, password:req.body.password}, (err, user)=>{
    //     if(err){
    //         console.log(err)
    //         res.json("Error")
    //     }
    //     else
    //         res.json(user)
    // })
    // return res.send("In Login")

})

app.listen(port, () => console.log("Listening on Port:", port))