const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;


const otpSchema = new Schema({
    email: {
        type: String,
        required: true,
    },
    otp: {
        type: Number,
    },
    timestamp: {
        type: Date,
        default: Date.now(),
    }
});

const otpModel = db.model('otp', otpSchema);

module.exports = otpModel;