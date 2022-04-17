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

<<<<<<< HEAD

// const mongoose = require("mongoose");

// const regUsersSchema = new mongoose.Schema({
//     user_name: String,
//     email: String,
//     password: String,
//     gender : String,
//     donor: Boolean,
//     user_contact_num: String,
//     blood_group: String,
//     notification_id: String,
// });

// const RegisteredUsersModel = mongoose.model("REGISTERED_USER", regUsersSchema);
// module.exports = RegisteredUsersModel;
=======
>>>>>>> main
