const mongoose = require("mongoose");

const adminSchema = new mongoose.Schema({
    admin_id : Number,
    admin_name: String,
    email: String,
    password: String,
    contact_num : Number
});

const AdminModel = mongoose.model("ADMIN", adminSchema);
module.exports = AdminModel;