// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:typed_data';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/get_category.dart';
import 'package:canteenflutter/api/vendor-side-api/home-screen-api/home-screen-components-api/update_product_data.dart';
import 'package:flutter/material.dart';

class UpdatePorductDataScreen extends StatefulWidget {
  // final AddedProductData data;
  final proName;
  final proPrice;
  final proDesc;
  final proQuantity;
  final id;
  final proCategory;
  const UpdatePorductDataScreen(
      {super.key,
      this.proName,
      this.proPrice,
      this.proDesc,
      this.proQuantity,
      this.id,
      this.proCategory});

  @override
  State<UpdatePorductDataScreen> createState() =>
      _UpdatePorductDataScreenState();
}

class _UpdatePorductDataScreenState extends State<UpdatePorductDataScreen> {
  late String userId;
  String base64Image = "";
  Uint8List? image;
  String mimeType = "";

  final proName = TextEditingController();
  final proPrice = TextEditingController();
  final proDesc = TextEditingController();
  final proCategory = TextEditingController();
  final proQuantity = TextEditingController();

  @override
  void initState() {
    super.initState();
    // proName.text = widget.data.proname.toString();
    // proPrice.text = widget.data.proprice.toString();
    // proQuantity.text = widget.data.proQuantity.toString();
    // proDesc.text = widget.data.proDesc.toString();

    proName.text = widget.proName.toString();
    proPrice.text = widget.proPrice.toString();
    proQuantity.text = widget.proQuantity.toString();
    proDesc.text = widget.proDesc.toString();
    proCategory.text = widget.proCategory.toString();
    // print(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    UpdateProductDataApiVendor.updateProduct(
                        widget.id,
                        {
                          "proname": proName.text,
                          "proprice": proPrice.text,
                          "proDesc": proDesc.text,
                          "proQuantity": proQuantity.text,
                          "proCategory": proCategory.text,
                        },
                        context);
                    // print(widget.data.id);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
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
              GestureDetector(
                // onTap: _pickImage,
                child: Container(
                  width: 150,
                  height: 150,
                  // color: Colors.black,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      base64Image.isEmpty
                          ? const Icon(
                              Icons.add,
                              size: 40,
                            )
                          : Image.memory(
                              base64Decode(base64Image),
                              width: 145,
                              height: 145,
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    TextField(
                      controller: proName,
                      obscureText: false,
                      cursorColor: Colors.blueGrey,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff65b08)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff65b08), width: 2),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Product Name',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: proPrice,
                      obscureText: false,
                      cursorColor: Colors.blueGrey,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff65b08)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff65b08), width: 2),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Product Price',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: proQuantity,
                      obscureText: false,
                      cursorColor: Colors.blueGrey,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff65b08)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff65b08), width: 2),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Product Quantity',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 30),
                    DropdownButtonFormField(
                      items: GetCategory.category.map((cat) {
                        return DropdownMenuItem(
                          value: cat,
                          child: Text(cat.categoryName),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          proCategory.text = val!.categoryName;
                        });
                      },
                      hint: (proCategory.text == "")
                          ? Text(widget.proCategory)
                          : Text(proCategory.text),
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
                    const SizedBox(height: 30),
                    TextField(
                      maxLines: 10,
                      controller: proDesc,
                      obscureText: false,
                      cursorColor: Colors.blueGrey,
                      cursorHeight: 25,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff65b08)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xfff65b08), width: 2),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Product Description',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
