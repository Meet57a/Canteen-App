import 'package:canteenflutter/api/common-api/home_screen_api.dart';
import 'package:canteenflutter/api/user-side-api/cart-add-get-api/add_to_cart_product.dart';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/order_product.dart';
import 'package:canteenflutter/constants/color_string.dart';
import 'package:canteenflutter/pages/user-side/home-screen-components/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderScreenUser extends StatefulWidget {
  final AddedProductData data;

  const OrderScreenUser({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<OrderScreenUser> createState() => _OrderScreenUserState();
}

class _OrderScreenUserState extends State<OrderScreenUser> {
  final cabinno = TextEditingController();
  var userId = "";
  String email = "";
  String fullname = "";
  String productName = "";
  int productPrice = 0;
  String productQuantity = "";
  String productDesc = "";
  String productCat = "";
  int totalprice = 0;
  String productId = "";

  List cabinList = ['mc151', 'mc152', 'mv153'];

  @override
  void initState() {
    super.initState();
    productName = widget.data.proname;
    productPrice = widget.data.proprice;
    productQuantity = widget.data.proQuantity;
    productDesc = widget.data.proDesc;
    productCat = widget.data.proCategory;
    totalprice = widget.data.proprice;
    productId = widget.data.id;

    loadData();
  }

  loadData() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId')!;
    email = prefs.getString('email')!;
    fullname = prefs.getString('fullName')!;
  }

  int _n = 1;
  // int totalprice = productPrice;

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
          child: Padding(
            padding: EdgeInsets.only(right: 75),
            child: SizedBox(
              height: 50,
              width: 200,
              // decoration: BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Order Screen'),
                ],
              ),
            ),
          ),
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
                    Column(
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: GestureDetector(
                            onTap: () {},
                            child: Image.network(
                              'https://pub-c2ce9a1d454a457ba9303eb6f3de07a2.r2.dev/$productId',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
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
              const SizedBox(height: 20),
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
