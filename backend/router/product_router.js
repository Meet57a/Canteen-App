const router = require('express').Router();
const ProductController = require('../controller/product_controller');
// const ProductService = require('../services/product_service');
router.post('/storeProduct',ProductController.addProduct);
router.post('/updateProduct/:id',ProductController.updateProduct);
router.post('/deleteProduct/:id',ProductController.deleteProduct);
router.post('/shortProductCategoryWise',ProductController.shortProductCategoryWise);
router.post('/createCat',ProductController.createCate);

router.post('/deleteCategory/:id',ProductController.deleteCategory);



module.exports = router