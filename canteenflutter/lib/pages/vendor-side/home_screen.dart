// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:canteenflutter/api/vendor-side-api/auth_api.dart';
import 'package:canteenflutter/api/vendor-side-api/home-screen-api/home-screen-components-api/delete_product.dart';
import 'package:canteenflutter/api/common-api/home_screen_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:canteenflutter/pages/vendor-side/home-screen-components/add_product_screen.dart';
import 'package:canteenflutter/pages/vendor-side/home-screen-components/category_wise_product.dart';
import 'package:canteenflutter/pages/vendor-side/home-screen-components/order_recived_screen.dart';
import 'package:canteenflutter/pages/vendor-side/home-screen-components/update_product_data_screen.dart';
import 'package:canteenflutter/pages/vendor-side/user_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenVendor extends StatefulWidget {
  const HomeScreenVendor({Key? key}) : super(key: key);

  @override
  State<HomeScreenVendor> createState() => _HomeScreenVendorState();
}

class _HomeScreenVendorState extends State<HomeScreenVendor> {
  var userId;
  var email;
  var token;
  var fullName;
  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future loadDetails() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token")!;
    fullName = prefs.getString('fullName')!;
    email = prefs.getString('email')!;
    userId = prefs.getString('userId')!;
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      HomeProductDisplayApiCommon.displayAddedProductInVendorandUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.black)),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderRecivedScreen()));
                },
                child: Image.asset(orderImg),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
          height: 80,
          color: const Color(0xfff65b08),
          child: Center(
            child: SizedBox(
              width: 400,
              height: 70,
              // color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VendorDetails()));
                      },
                      icon: const Icon(Icons.person)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddProductScreenVendor()));
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CategoryScreenVendro()));
                      },
                      icon: const Icon(Icons.category)),

                  // Icon/Button(onPressed: () {}, icon: Icon(Icons.trolley)),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.person))
                ],
              ),
            ),
          )),
      drawer: Drawer(
        child: ElevatedButton(
            onPressed: () {
              AuthVendor.logoutUser(context);
            },
            child: const Text("LogOut")),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future:
              HomeProductDisplayApiCommon.displayAddedProductInVendorandUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<AddedProductData> pdata = snapshot.data;
              if (pdata.isEmpty) {
                return const Center(
                  child: Text("No Product Data"),
                );
              }
              return ListView.builder(
                itemCount: pdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        width: 370,
                        height: 150,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 10,
                            ),
                          ],
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 130,
                                width: 130,
                                color: Colors.black,
                                child: Image.network(
                                  'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/${pdata[index].id}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 20),
                                height: 130,
                                width: 180,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      pdata[index].proname,
                                      style: const TextStyle(fontSize: 25),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "\u{20B9}${pdata[index].proprice}/",
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          pdata[index].proQuantity,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdatePorductDataScreen(
                                                    proName:
                                                        pdata[index].proname,
                                                    proDesc:
                                                        pdata[index].proDesc,
                                                    proPrice:
                                                        pdata[index].proprice,
                                                    proQuantity: pdata[index]
                                                        .proQuantity,
                                                    proCategory: pdata[index]
                                                        .proCategory,
                                                    id: pdata[index].id,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child:
                                                  const Icon(Icons.edit_note),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              DeleteProductApiVendor
                                                  .deleteProduct(
                                                      pdata[index].id);
                                              pdata.removeAt(index);
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Colors.black),
                                              ),
                                              child: const Icon(Icons.delete),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
