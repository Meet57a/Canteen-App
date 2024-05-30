        const addtocartservice = require('../services/add_to_cart_product_service')

exports.addtocartproductcontroller = async (req, res,next) => {
    try {
        const { productName, totalPrice,cabinNo, productQuantaty,productId,productPrice,userId } = req.body;
        console.log(req.body);
        let addtocartproduct = await addtocartservice.addtocart(productName, totalPrice, cabinNo, productQuantaty,productId,productPrice,userId);
        res.json({ status: true, success: addtocartproduct });

    } catch (err) {
        next(err);
    }
}


exports.deleteOrderedProduct = ('/deleteCartProduct/:id', async (req, res) => {
    let id = req.params.id;
    console.log(id);
    let deleteProduct = await addtocartservice.deleteCartData(id);
    res.json({ status: true, success: deleteProduct });
})