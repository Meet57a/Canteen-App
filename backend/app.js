const express = require('express');
const body_parser = require('body-parser');
const userVendorRouter = require('./router/user_vendor_router');
const ProductRouter = require('./router/product_router');
const orderproRouter = require('./router/order_router');
const getRouter = require('./router/get_router');
const addtocart = require('./router/cart_router');

const app = express();
app.use(body_parser.json({
    limit: '50mb'
}));

app.use('/', userVendorRouter);
app.use('/', ProductRouter);
app.use('/', orderproRouter);
app.use('/', getRouter);
app.use('/', addtocart);



module.exports = app;