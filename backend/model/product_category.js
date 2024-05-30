const mongoose = require('mongoose');
const db = require('../config/db');
const { Schema } = mongoose;
const UserModel = require('./user_model');


const categoryCreatedSchema = new Schema({
    userId: {
        type: Schema.Types.ObjectId,
        ref: UserModel.modelName
    },
    categoryName: {
        type: String,
        required: false,
    }
});

const categoryCreate = db.model('productcategories', categoryCreatedSchema);


module.exports = categoryCreate;
