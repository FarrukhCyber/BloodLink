const mongoose = require('mongoose')
const Schema = mongoose.Schema

const newSchema = new Schema({
    userName:String,
    password:String,
    email:String,
    phoneNumber:Number,
    bloodType:String
})

module.exports = mongoose.model('User', newSchema)