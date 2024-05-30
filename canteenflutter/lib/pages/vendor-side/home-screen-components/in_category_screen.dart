
// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:canteenflutter/api/common-api/get_product_category_wise.dart';
import 'package:canteenflutter/api/vendor-side-api/home-screen-api/home-screen-components-api/delete_product.dart';
import 'package:canteenflutter/pages/vendor-side/home-screen-components/update_product_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InCategoryScreenVendor extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  // ignore: prefer_typing_uninitialized_variables
  final category;
  const InCategoryScreenVendor({Key? key, this.category}) : super(key: key);

  @override
  State<InCategoryScreenVendor> createState() => _InCategoryScreenUserState();
}

class _InCategoryScreenUserState extends State<InCategoryScreenVendor> {
  // late String email = "";
  // late String userName = "";
  // String userId = "";
  var token;

  @override
  void initState() {
    super.initState();
    // HomeProductDisplayApiCommon.displayAddedProductInVendorandUser();
  }

  getUserData() async {
    var prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    //  print(widget.token);
    // userId = jwtDecodedToken['_id'];
    // email = jwtDecodedToken['email'];
    // userName = jwtDecodedToken['fullName'];
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      GetStoredProductDataShortedByCategory.getProductDataCategoryWise(
          widget.category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future:
              GetStoredProductDataShortedByCategory.getProductDataCategoryWise(
                  widget.category),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<GetAddedProductDataCategoryWiseData> pdata = snapshot.data;

              if (pdata.isEmpty) {
                return const Center(
                  child: Text('No Data'),
                );
              }
              return ListView.builder(
                itemCount: pdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        width: 390,
                        height: 150,
                        // color: Colors.white70,
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
                                  'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/${pdata[index].proid}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    // color: Colors.black,
                                    height: 100,
                                    width: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          pdata[index].proname,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                        Text(
                                          "\u{20B9}${pdata[index].proprice}",
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  ),
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
                                                  proName: pdata[index].proname,
                                                  proPrice:
                                                      pdata[index].proprice,
                                                  proDesc: pdata[index]
                                                      .prodescription,
                                                  proQuantity:
                                                      pdata[index].proqty,
                                                      id: pdata[index].proid,
                                                      proCategory: pdata[index].procategory,
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
                                            child: const Icon(Icons.edit_note),
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        GestureDetector(
                                          onTap: () {
                                            DeleteProductApiVendor
                                                .deleteProduct(
                                                    pdata[index].proid);
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
