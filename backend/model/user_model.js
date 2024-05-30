const mongoose = require('mongoose');
const db = require('../config/db');
const bcrypt = require("bcrypt");
const { use } = require('../router/user_vendor_router');

const { Schema } = mongoose;    

const userSchema = new Schema({
    fullName: {
        type: String,
        required: true
    },
    email: {
        type: String,
        lowercase: true,
        required: true,
        uniqe: true
    },
    password: {
        type: String,
        required: true
    },
    type: {
        type: String,
        required: true,

    }

});

userSchema.pre('save', async function () {
    try {
        var user = this;
        const salt = await (bcrypt.genSalt(10));
        const hashpass = await bcrypt.hash(user.password, salt);
        user.password = hashpass;
    } catch (err) {
        throw err;
    }
});



        const UserModel = db.model('user', userSchema);

        module.exports = UserModel;     
