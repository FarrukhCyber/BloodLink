const mongoose = require("mongoose");

const bloodRequestSchema = new mongoose.Schema({
    req_id: Number, //TODO: make it auto increment
    attendant_name: String,
    attendant_num: String,
    blood_group: String,
    status: Boolean,
    quantity: String,
    user_contact_num: String,
    admin_id: Number,
    moderator_id: Number,
    date: Date,
    time: Date,
    hospital : String,
    city: String
});

const RequestModel = mongoose.model("blood_requests", bloodRequestSchema);
module.exports = RequestModel;