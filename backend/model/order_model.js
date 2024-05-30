const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;
const UserModel = require('./user_model');

const productorderSchema = new Schema({
    Id: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    email: {
        type: String,
        required: true,
    },
    CustomerName: {
        type: String,
        required: true,
    },
    proName: {
        type: String,
        required: true,
    },
    proPrice: {
        type: Number,
        required: true
    },
    cabinno: {
        type: String,
        required: true,
    },
    productQuantaty:{
        type:Number,
        required:true
    },
    productId:{
        type: String,
        required:true,
    },
    userId:{
        type: String,
        required:true,
    }
});

const ProductorderModel = db.model('orderedproduct', productorderSchema);

module.exports = ProductorderModel;

