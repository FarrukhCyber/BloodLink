const express = require('express')
const app = express()
const port = 8080 || process.env.Port
const mongoose = require('mongoose')
const User = require('./models/user_model')

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

app.post('/login', (req, res) => {
    const {userName, password} = req.body
    console.log(userName, password)
    // res.json({msg:"success"})
    User.findOne({userName:req.body.userName, password:req.body.password}, (err, user)=>{
        if(err){
            console.log("Sendnig", err)
            // res.json({msg: err})
        }
        else{
            if(user==null) // exists
            {
                console.log("Sending", user)
                res.json({msg:"null"})
            }
            else
            {
                console.log("exists", user)
                res.json({msg:user.email})
            }
        }
    })
    // return res.send("In Login")
    console.log("Login")
})
app.post('/signup', (req, res) => {
    const {userName, password, phoneNumber, bloodType, email} = req.body
    console.log(userName, password, phoneNumber, bloodType, email)
    if(!userName || !password || !phoneNumber || !bloodType || !email)
        console.log("null values")
    else{
    // res.json({msg:"success"})
    User.findOne({email:email}, (err, user)=>{
        if(err){
            console.log("err: ", err)
            // res.json({signup: "Email exists"})
        }
        else{
            if(user==null)
            {
                console.log("user is new ", user)
                var tempUser = new User({
                    userName:userName,
                    password:password,
                    bloodType:bloodType,
                    phoneNumber:Number(phoneNumber),
                    email:email
                })
                console.log(tempUser)
                tempUser.save((err,doc)=>{
                    if(!err) res.json({signup: tempUser.email})
                    else console.log("there was erorr", err)
                })
            }else {
                console.log("Sending user exists", user.email)
                res.json({signup: "Email exists"})
            }
        }
    })}
    // return res.send("In Login")
    console.log("Signup")
})
app.listen(port, () => console.log("Listening on Port:", port))