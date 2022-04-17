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
    deviceID: String,
    notifyAllowed: Boolean,
    emailAllowed: Boolean,
    unavailable:Boolean
})

module.exports = mongoose.model('user', newSchema)

