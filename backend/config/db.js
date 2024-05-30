const { default: mongoose } = require('mongoose');
const mangoose = require('mongoose');
const MongoClient = require('mongodb').MongoClient  

const database = 'canteenDB'
const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/' + database).on('open',()=>{
    console.log ("MongoDb Connected");
}).on('error',()=>{
    console.log ("MongoDb Connection error.");

});
module.exports = connection;