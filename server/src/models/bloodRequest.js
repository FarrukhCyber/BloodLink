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
<<<<<<< HEAD
    time: Date,    
=======
    time: Date,
>>>>>>> main
    hospital : String,
    city: String
});

<<<<<<< HEAD
const RequestModel = mongoose.model("blood_request", bloodRequestSchema);
=======
const RequestModel = mongoose.model("blood_requests", bloodRequestSchema);
>>>>>>> main
module.exports = RequestModel;