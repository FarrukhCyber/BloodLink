const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    userName:String,
    password:String,
    email:String,
    phoneNumber:String,
    bloodType:String,
    gender:String, 
    age: Date,
    donor:Boolean,
    deviceID: String
})

module.exports = mongoose.model('user', newSchema)