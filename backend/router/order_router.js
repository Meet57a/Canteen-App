const router = require('express').Router();
const orderProduct = require('../controller/order_controller'); 


router.post('/orderProduct',orderProduct.orderpro);
router.post('/deleteOrderedProduct/:id',orderProduct.deleteOrderedProduct);


module.exports = router