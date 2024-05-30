const OrderServices = require('../services/order_service');

exports.orderpro = async (req, res, next) => {
    try {

        const { email, CustomerName, proName, proPrice, cabinno, productQuantaty,productId,userId } = req.body;
        console.log(req.body);
        let productorder = await OrderServices.orderpro(email, CustomerName, proName, proPrice, cabinno,productQuantaty,productId,userId);
        res.json({ status: true, success: productorder });

    } catch (err) {
        next(err);
    }
}

exports.deleteOrderedProduct = ('/deleteOrderedProduct/:id', async (req, res) => {
    let id = req.params.id;
    console.log(id);
    let deleteProduct = await OrderServices.deleteOrderedData(id);
    res.json({ status: true, success: deleteProduct });
})



