const mongoose = require("mongoose");

const regUsersSchema = new mongoose.Schema({
    user_name: String,
    email: String,
    password: String,
    gender : String,
    donor: Boolean,
    user_contact_num: String,
    blood_group: String,
    notification_id: String,
});

const RegisteredUsersModel = mongoose.model("REGISTERED_USER", regUsersSchema);
module.exports = RegisteredUsersModel;