const ProductServices = require('../services/product_service');
const router = require('express').Router();
const ProductCategoryModel = require("../model/product_category");
// const uploadFile = require('../services/uploadimg');

exports.addProduct = async (req, res, next) => {
    try {

        const { userId, proName, proPrice, proDesc, proCategory, proQuantity, image, mimeType } = req.body;

        let product = await ProductServices.addProduct(userId, proName, proPrice, proDesc, proCategory, proQuantity, image, mimeType);
        res.json({ status: true, success: product });



    } catch (err) {
        next(err);
    }
}


exports.updateProduct = ('/updateProduct/:id', async (req, res) => {

    try {
        let id = req.params.id;
        console.log(id);
        console.log(req.body);


        let updateProduct = await ProductServices.updateProduct(id, req.body);

        res.json({ status: true, success: updateProduct });
    } catch (error) {

    }
})
exports.deleteProduct = ('/deleteProduct/:id', async (req, res) => {
    let id = req.params.id;
    console.log(id);
    let deleteProduct = await ProductServices.deleteProduct(id);
    res.json({ status: true, success: deleteProduct });
})

exports.shortProductCategoryWise = async (req, res) => {
    try {
        const { proCategory } = req.body;
        // console.log(proCategory);
        let shortProduct = await ProductServices.categoryShortProductService(proCategory, res);

    } catch (err) {
        console.log(err);
    }
}

exports.createCate = async (req, res) => {
    const { categoryName } = req.body;
    try {
        // console.log(categoryName)
        const catExists = await ProductCategoryModel.findOne({ categoryName: categoryName })
        console.log(catExists)

        if (catExists == null) {
            await ProductServices.createCategory(categoryName, res);

        } else {
            return res.status(400).json({ message: "Category already exists" });
        }
    } catch (error) {
        console.log(error);
    }
}




exports.deleteCategory = ('/deleteProduct/:id', async (req, res) => {
    let id = req.params.id;
    console.log(id);
    let deleteProduct = await ProductServices.deleteCategory(id);
    res.json({ status: true, success: deleteProduct });
})