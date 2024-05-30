const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;
const UserModel = require('./user_model');



const productSchema = new Schema({

    userId: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    proName: {
        type: String,
        required: true,

    },
    proPrice: {
        type: Number,
        required: true
    },
    proDesc: {
        type: String,
        required: false
    },
    proCategory: {
        type: String,
        required: true,
    },
    proQuantity: {
        type: String,
        required: true,
    },


});



const ProductModel = db.model('product', productSchema);


module.exports = ProductModel;
