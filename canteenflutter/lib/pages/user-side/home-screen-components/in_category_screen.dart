import 'package:canteenflutter/api/common-api/get_product_category_wise.dart';
import 'package:canteenflutter/pages/user-side/order-screen/product_order_screen_for_category.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InCategoryScreenUser extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables

  // ignore: prefer_typing_uninitialized_variables
  final category;
  const InCategoryScreenUser({Key? key, this.category}) : super(key: key);

  @override
  State<InCategoryScreenUser> createState() => _InCategoryScreenUserState();
}

class _InCategoryScreenUserState extends State<InCategoryScreenUser> {
  // late String email = "";
  // late String userName = "";
  // String userId = "";
  // ignore: prefer_typing_uninitialized_variables
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
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreenCategoryWiseUser(
                                // token: token,
                                data: pdata[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: Colors.white,
                          child: SizedBox(
                            width: 390,
                            height: 150,
                            // color: Colors.white70,

                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  SizedBox(
                                    // color: Colors.black,
                                    height: 130,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                        // child: Container(
                        //   height: 190,
                        //   width: 150,
                        //   decoration: BoxDecoration(
                        //     // color: Color(0xfff65b08),
                        //     borderRadius: BorderRadius.circular(20),
                        //     border: Border.all(
                        //       color: Colors.black,
                        //       width: 2,
                        //     ),
                        //   ),
                        //   child: Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Container(
                        //         child: Image.network(
                        //           'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/' +
                        //               pdata[index].id,
                        //           fit: BoxFit.cover,
                        //           height: 130,
                        //           width: 130,
                        //         ),
                        //       ),
                        //       Container(
                        //         height: 50,
                        //         width: 145,
                        //         color: Colors.black,
                        //       ),
                        //     ],
                        //   ),
                        // ),
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
