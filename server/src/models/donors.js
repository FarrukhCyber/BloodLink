const mongoose = require("mongoose");

const donorsSchema = new mongoose.Schema({
    user_contact_num: Number,
    blood_group: String,
    diabetes: Boolean,
    blood_disease: Boolean,
    vaccinated: Boolean,
    last_donated: String,
    region: String,
    gender : String,
    plasma: Boolean,
});

const DonorsModel = mongoose.model("donors", donorsSchema);
module.exports = DonorsModel;