const router = require('express').Router();
const GetService = require('../services/get_services');


router.get('/getAddedProductData',GetService.getAddedProduct);
router.get('/getOrderedProductData',GetService.getOrderedProduct);
router.post('/getAddedProductInCart',GetService.getAddedProductInCartData);
router.post('/getOrderedProductToUserScreen',GetService.getOrderedProductToUserScreen);
router.post('/getCategoryList',GetService.getCategoryList);

// router.get('/getUserData',GetService.getUserData);


module.exports = router

