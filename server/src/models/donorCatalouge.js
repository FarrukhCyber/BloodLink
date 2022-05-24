const mongoose = require('mongoose')
const Schema = mongoose.Schema

// what to do with non Number roll number
// are the rest of the data types fine?

const newSchema = new Schema({
    Name: String,
    Gender: String,
    RollNo:	String, 
    Blood: String,
    Status: String,
    Number:String, 
    LastContact: String,
    City:String

})

module.exports = mongoose.model('catalouge', newSchema)

