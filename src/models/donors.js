const mongoose = require("mongoose");

const donorsSchema = new mongoose.Schema({
    user_contact_num: String,
    blood_group: String,
    diabetes: Boolean,
    blood_disease: Boolean,
    vaccinated: Boolean,
    last_donated: Date,
    region: String,
    gender : String,
    plasma: Boolean,
    email: Boolean,
    notification : Boolean,
    available: Boolean
});

const DonorsModel = mongoose.model("donors", donorsSchema);
module.exports = DonorsModel;