const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;
const UserModel = require('./user_model');

const addToCartSchema = new Schema({
    Id: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    productName: {
        type: String,
        required: true,
    },
    totalPrice: {
        type: Number,
        required: true
    },
    cabinNo: {
        type: String,
        required: false,
    },
    productQuantaty: {
        type: Number,
        required: true
    },
    productId: {
        type: String,
        required: true
    },
    productPrice: {
        type: Number,
        required: true,
    },
    userId: {
        type: String,
        required: true,
    }
});

const addToCartProductModel = db.model('cart', addToCartSchema);

module.exports = addToCartProductModel;

