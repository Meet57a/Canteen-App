const productmodel = require('../model/product_model');
const ordermodel = require('../model/order_model');
const cartmodel = require('../model/cart_model');
const categorymodel = require('../model/product_category');
const userModel = require('../model/user_model');


exports.getAddedProduct = async (req, res) => {
    try {

        const documents = await productmodel.find({});
        // console.log(documents);
        res.json(documents);
    } catch (err) {
        console.error('Error fetching data:', err);

        res.status(500).json({ error: 'Error fetching data' });
    }
}

exports.getOrderedProduct = async (req, res) => {
    try {

        const documents = await ordermodel.find({});
        res.json(documents);
    } catch (err) {
        console.error('Error fetching data:', err);

        res.status(500).json({ error: 'Error fetching data' });
    }
}

exports.getOrderedProductToUserScreen = async (req, res) => {
    try {

        const { userId } = req.body;
        
        const orderedProduct = await ordermodel.find({ userId });
        res.status(200).json(orderedProduct)
    } catch (err) {
        console.error('Error fetching data:', err);

        res.status(500).json({ error: 'Error fetching data' });
    }
}

exports.getAddedProductInCartData = async (req, res) => {
    try {
        const { userId } = req.body;
        // console.log(userId);
        const product = await cartmodel.find({ userId });
        res.status(200).json(product)
        
    } catch (err) {
        console.error
            ('Error fetching data:', err);

        res.status(500).json({ error: 'Error fetching data' });
    }
}

exports.getCategoryList = async (req, res) => {
    try {

        const documents = await categorymodel.find({});
        res.json(documents);
    } catch (err) {
        console.error('Error fetching data:', err);

        res.status(500).json({ error: 'Error fetching data' });
    }
}
