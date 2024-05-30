const ProductModel = require('../model/product_model');
// const uploadFile = require('./uploadimg');
const S3 = require("../config/s3-config");
const { PutObjectCommand } = require("@aws-sdk/client-s3");
const ProductCategoryModel = require("../model/product_category");


class ProductServices {
  static async addProduct(userId, proName, proPrice, proDesc, proCategory, proQuantity, image, mimeType) {


    const addProduct = new ProductModel({ userId, proName, proPrice, proDesc, proCategory, proQuantity });
    const product = await addProduct.save();
    const productID = product._id.toString();


    // await uploadFile(image, mimeType, productId);
      const command = new PutObjectCommand({
        Bucket: "mu-canteen",
        Body: image,
        ContentType: mimeType,
        ContentLength: image.length,
        Key: productID,
      });
    try {
      await S3.send(command);
    } catch (err) {
      console.log("Error", err);
    }
    return product;
  }

  static async updateProduct(id, body) {
    try {
      const updatedDocument = await ProductModel.findOneAndUpdate(
        { _id: id },
        {
          $set: {
            proName: body.proname,
            proPrice: body.proprice,
            proDesc: body.proDesc,
            proQuantity: body.proQuantity,
            proCategory:body.proCategory,
          },
        },
        { new: true }
      );

      if (updatedDocument) {
        return { success: true };
      } else {
        return { success: false };
      }
    } catch (err) {
      // Handle any potential errors, e.g., database connection issues or validation errors.
      throw err;
    }
  }

  static async deleteProduct(id) {
    const deletedProduct = await ProductModel.findByIdAndDelete(id);
    if (!deletedProduct) {
      throw new Error('No such product exists');
    }
    return { success: true };

  }

  static async categoryShortProductService(category, res) {
    const shortProduct = await ProductModel.find({ proCategory: category });
    if (shortProduct) {
      console.log(shortProduct);
      res.status(200).json(shortProduct);
    } else {
      res.status(400).json({ message: "No such product exists" });
    }
  }

  static async createCategory(category, res) {

    console.log(category);
    const createCategory = new ProductCategoryModel({ categoryName: category });
    const categoryCreated = await createCategory.save();
    if (categoryCreated) {
      res.status(200).json({ message: "Category created successfully" });
    } else {
      res.status(400).json({ message: "Category not created" });
    }

  }

  static async deleteCategory(id) {
    const deletedProduct = await ProductCategoryModel.findByIdAndDelete(id);
    if (!deletedProduct) {
      throw new Error('No such product exists');
    }
    return { success: true };
  }
}

module.exports = ProductServices;