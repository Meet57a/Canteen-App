const orderModel = require('../model/order_model');

class OrderServices {
    static async orderpro(email, CustomerName, proName, proPrice, cabinno, productQuantaty, productId, userId) {
        const orderpro = new orderModel({ email, CustomerName, proName, proPrice, cabinno, productQuantaty, productId, userId });
        return await orderpro.save();
    }
    static async deleteOrderedData(id) {
        const deletedProduct = await orderModel.findByIdAndDelete(id);
        if (!deletedProduct) {
            throw new Error('No such product exists');
        }
        return { success: true };

    }
}
module.exports = OrderServices;