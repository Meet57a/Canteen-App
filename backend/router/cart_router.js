const router = require('express').Router();
const addToCartProduct = require('../controller/add_to_cart_product_controller'); 


router.post('/addtocart', addToCartProduct.addtocartproductcontroller);
router.post('/deleteCartProduct/:id', addToCartProduct.deleteOrderedProduct);


module.exports = router