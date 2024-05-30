// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:canteenflutter/api/user-side-api/cart-add-get-api/get_added_to_cart_product.dart';
import 'package:canteenflutter/api/user-side-api/cart-add-get-api/remove_product_from_cart.dart';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/order_product.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreenUser extends StatefulWidget {
  final userId;
  const CartScreenUser({Key? key, @required this.userId}) : super(key: key);

  @override
  State<CartScreenUser> createState() => _CartScreenUserState();
}

class _CartScreenUserState extends State<CartScreenUser> {
  var userId;
  var fullname;
  var email;

  int totalPriceIncart = 0;
  Future refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      GetAddedToCartProductApiUser.displayAddedProductInVendorandUser(userId);
      getCartTotal();
    });
  }

  @override
  void initState() {
    super.initState();
    loadDetail();
    loadCartData();
    refresh();
  }

  Future loadCartData() async {
    Future(
      () => GetAddedToCartProductApiUser.displayAddedProductInVendorandUser(
          userId),
    );
    getCartTotal();
  }

  loadDetail() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
    fullname = prefs.getString('fullName');
    email = prefs.getString('email');
  }

  getCartTotal() {
    int total = 0;
    for (var i = 0;
        i < GetAddedToCartProductApiUser.getaddedproductincart.length;
        i++) {
      total = total +
          GetAddedToCartProductApiUser.getaddedproductincart[i].totalPrice;
    }
    totalPriceIncart = total;
  }

  void incrementQuantity(pdata, index) {
    if (pdata[index].proQuantity >= 0) {
      pdata[index].proQuantity++;
      pdata[index].totalPrice =
          pdata[index].totalPrice + pdata[index].productPrice;
    }
    setState(() {});
  }

  void decrementQuantity(pdata, index) {
    if (pdata[index].proQuantity >= 1) {
      pdata[index].proQuantity--;
      pdata[index].totalPrice =
          pdata[index].totalPrice - pdata[index].productPrice;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List pdata = GetAddedToCartProductApiUser.getaddedproductincart;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Padding(
            padding: EdgeInsets.only(right: 75),
            child: SizedBox(
              height: 50,
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Cart"),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        // ignore: unnecessary_null_comparison
        child: Column(
          children: [
            SizedBox(
              height: 680,
              child: Expanded(
                // ignore: unnecessary_null_comparison
                child: (pdata != null && pdata.isNotEmpty)
                    ? ListView.builder(
                        itemCount: GetAddedToCartProductApiUser
                            .getaddedproductincart.length,
                        itemBuilder: (BuildContext context, int index) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    color: Colors.white,
                                    shadowColor: Colors.grey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                color: const Color(0xfff65b08),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Image.network(
                                                  'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/${pdata[index].productId}'),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 18),
                                              height: 150,
                                              width: 200,
                                              decoration: BoxDecoration(
                                                // color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Product Name : ${pdata[index].productName}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Total Price : \u{20B9}${pdata[index].totalPrice.toString()}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Total Price : \u{20B9}${pdata[index].productPrice}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                  Text(
                                                    "Cabin No : ${pdata[index].cabinNo}",
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              height: 90,
                                              width: 150,
                                              // color: Colors.amber,
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      decrementQuantity(
                                                          pdata, index);
                                                      getCartTotal();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Icon(
                                                        Icons.remove,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    pdata[index]
                                                        .proQuantity
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  GestureDetector(
                                                    onTap: () {
                                                      incrementQuantity(
                                                          pdata, index);
                                                      getCartTotal();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 45,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                      child: const Icon(
                                                        Icons.add,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                SizedBox(
                                                  width: 120,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      DeleteCartDataApiUser
                                                          .deleteCartDataUser(
                                                              pdata[index].id,
                                                              context);
                                                      pdata.removeAt(index);
                                                      getCartTotal();
                                                      setState(() {});
                                                    },
                                                    child: const Text("Remove"),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 120,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (pdata[index]
                                                              .proQuantity >=
                                                          1) {
                                                        OrderProductApiUser
                                                            .orderproductany(
                                                          fullname,
                                                          pdata[index]
                                                              .productName,
                                                          pdata[index]
                                                              .totalPrice,
                                                          pdata[index].cabinNo,
                                                          email,
                                                          pdata[index]
                                                              .proQuantity,
                                                          pdata[index]
                                                              .productId,
                                                          context,
                                                          userId,
                                                        );
                                                        DeleteCartDataApiUser
                                                            .deleteCartDataUser(
                                                                pdata[index].id,
                                                                context);
                                                        getCartTotal();
                                                        pdata.removeAt(index);
                                                        setState(() {});
                                                      } else {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                            content: Text(
                                                                "Please add quantity"),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                    child: const Text(
                                                      "Place Order",
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text("Cart is Empty"),
                      ),
              ),
            ),
            Expanded(
              child: Card(
                child: SizedBox(
                  width: 380,
                  height: 100,
                  child: Row(
                    children: [
                      const SizedBox(width: 50),
                      const Text(
                        "Total",
                        style: TextStyle(fontSize: 25),
                      ),
                      const SizedBox(width: 200),
                      Text(
                        '\u{20B9}${totalPriceIncart.toString()}',
                        style: const TextStyle(fontSize: 25),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
