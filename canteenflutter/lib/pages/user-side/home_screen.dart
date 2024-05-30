import 'package:canteenflutter/api/common-api/home_screen_api.dart';
import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/cart_screen.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/category_screen.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/order_show_screen.dart';
import 'package:canteenflutter/pages/user-side/order-screen/product_order_screen.dart';
import 'package:canteenflutter/pages/user-side/user_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/image_string.dart';

class HomeScreenUser extends StatefulWidget {
  const HomeScreenUser({Key? key}) : super(key: key);

  @override
  State<HomeScreenUser> createState() => _HomeScreenUserState();
}

class _HomeScreenUserState extends State<HomeScreenUser> {
  var email = "";
  var fullName = "";
  var userId = "";
  var token = "";

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
    setState(() {});
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
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 150),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              // decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Image.asset(MSpalsIcon),
                  // Text('MU Canteen'),
                  Container(
                    height: 75,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff65b08),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    GetOrderedDataForUser(userId: userId)));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.black,
                        // Background color
                      ),
                      child: Image.asset(orderImg),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
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
                                builder: (context) => const UserDetails()));
                      },
                      icon: const Icon(Icons.person)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const CategoryScreenUser()));
                      },
                      icon: const Icon(Icons.category)),

                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreenUser(
                                    userId: userId,
                                  )),
                        );
                      },
                      icon: const Icon(Icons.trolley)),
                  // IconButton(onPressed: () {}, icon: Icon(Icons.person))
                ],
              ),
            ),
          )),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 170,
                  width: 290,
                  decoration: BoxDecoration(
                    color: const Color(0xfff65b08),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.white,
                              // backgroundImage:
                              // AssetImage('assets/images/logo.png'),
                            ),
                          ),
                          Text(
                            (fullName),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(email),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthUser.logoutUser(context);
                },
                child: const Text('LogOut'),
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future:
              HomeProductDisplayApiCommon.displayAddedProductInVendorandUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData ||
                fullName == "" ||
                email == "" ||
                userId == "") {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<AddedProductData> pdata = snapshot.data;
              if (pdata.isEmpty) {
                return const Center(
                  child: Text('No Product Added'),
                );
              }
              return ListView.builder(
                itemCount: pdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Column(
                    children: [
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreenUser(
                                data: pdata[index],
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          shadowColor: Colors.grey,
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          child: SizedBox(
                            width: 390,
                            height: 150,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  SizedBox(
                                    // color: Colors.black,
                                    height: 130,
                                    width: 150,
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
