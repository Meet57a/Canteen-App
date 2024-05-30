const cartModel = require('../model/cart_model');

class AddToCartProductService {
    static async addtocart(productName, totalPrice, cabinNo, productQuantaty, productId, productPrice, userId) {
        const addingtocart = new cartModel({ productName, totalPrice, cabinNo, productQuantaty, productId, productPrice, userId });
        return await addingtocart.save();
    }

    static async deleteCartData(id) {
        const deletedProduct = await cartModel.findByIdAndDelete(id);
        if (!deletedProduct) {
            throw new Error('No such product exists');
        }
        return { success: true };

    }
}
module.exports = AddToCartProductService;