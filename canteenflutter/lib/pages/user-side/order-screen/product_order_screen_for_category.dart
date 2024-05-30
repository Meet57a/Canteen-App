import 'package:canteenflutter/api/common-api/get_product_category_wise.dart';
import 'package:canteenflutter/api/user-side-api/cart-add-get-api/add_to_cart_product.dart';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/order_product.dart';
import 'package:canteenflutter/constants/color_string.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreenCategoryWiseUser extends StatefulWidget {
  final GetAddedProductDataCategoryWiseData data;
  const OrderScreenCategoryWiseUser({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderScreenCategoryWiseUser> createState() =>
      _OrderScreenCategoryWiseUserState();
}

class _OrderScreenCategoryWiseUserState
    extends State<OrderScreenCategoryWiseUser> {
  final cabinno = TextEditingController();

  String productId = "";
  String productName = "";
  int productPrice = 0;
  int _n = 1;
  int totalprice = 0;
  // ignore: prefer_typing_uninitialized_variables
  var fullname;
  // ignore: prefer_typing_uninitialized_variables
  var email;
  // ignore: prefer_typing_uninitialized_variables
  var userId;
  // ignore: prefer_typing_uninitialized_variables
  var token;

  @override
  void initState() {
    super.initState();
    productId = widget.data.proid;
    productName = widget.data.proname;
    productPrice = widget.data.proprice;
    totalprice = productPrice;
    getUserDetail();
  }

  List cabinList = ['mc151', 'mc152', 'mv153'];

  getUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token");
    userId = prefs.getString('userId');
    email = prefs.getString('email');
    fullname = prefs.getString('fullName');
  }

  void add() {
    setState(() {
      _n++;
      totalprice = productPrice + totalprice;
    });
  }

  void minus() {
    if (_n >= 1) {
      setState(() {
        _n--;
        totalprice = totalprice - productPrice;
        // _n--;
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Order Screen'),
        ),
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                width: 400,
                // decoration: BoxDecoration(color: Colors.red),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 200,
                      decoration: const BoxDecoration(color: Colors.red),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: GestureDetector(
                              onTap: () {},
                              child: Image.network(
                                  'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/$productId'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 200,
                      width: 125,
                      // decoration: BoxDecoration(color: Colors.red),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            (productName),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '\u{20B9}$productPrice',
                            style: const TextStyle(
                              fontSize: 25,
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 300,
                // decoration: BoxDecoration(color: Colors.red),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        minus();
                      },
                      child: Container(
                        height: 30,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.remove,
                        ),
                      ),
                    ),
                    Text('$_n'),
                    GestureDetector(
                      onTap: () {
                        add();
                      },
                      child: Container(
                        height: 30,
                        width: 25,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.add,
                        ),
                      ),
                    ),
                    Text(
                      'Total \u{20B9}$totalprice',
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100,
                width: 300,
                // decoration: BoxDecoration(color: Colors.red),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 200, top: 5),
                      child: Text(
                        'Enter cabin no',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextField(
                      controller: cabinno,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff65b08),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xfff65b08),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: DropdownButtonFormField(
                  items: cabinList.map<DropdownMenuItem<Object>>((item) {
                    return DropdownMenuItem<Object>(
                      value: item,
                      child: Text(item.toString()),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      cabinno.text = val.toString();
                    });
                  },
                  hint: cabinno.text == ""
                      ? const Text("Select cabino")
                      : Text(cabinno.text),
                  borderRadius: BorderRadius.circular(10),
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff65b08)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xfff65b08), width: 2),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if (_n >= 1) {
                      OrderProductApiUser.orderproductany(
                          fullname,
                          productName,
                          totalprice,
                          cabinno.text,
                          email.toString(),
                          _n,
                          productId,
                          context,
                          userId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please make some order")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(orangeColor),
                    shadowColor: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Place order',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if (_n >= 1) {
                      AddToCartProductApiUser.addToCart(
                        productName,
                        totalprice,
                        cabinno.text,
                        _n,
                        productId,
                        productPrice,
                        userId,
                        context,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please make some order")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(orangeColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Add to Your Cart",
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 60,
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreenUser(
                                  userId: userId,
                                )));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(orangeColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Go to Your Cart",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
