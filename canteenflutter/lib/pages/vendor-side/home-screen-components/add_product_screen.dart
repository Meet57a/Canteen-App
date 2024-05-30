// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:canteenflutter/api/user-side-api/home-screen-components-api/get_category.dart';
import 'package:canteenflutter/api/vendor-side-api/home-screen-api/home-screen-components-api/add_product.dart';
import 'package:canteenflutter/api/vendor-side-api/home-screen-api/home-screen-components-api/create_category.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddProductScreenVendor extends StatefulWidget {
  const AddProductScreenVendor({Key? key}) : super(key: key);

  @override
  State<AddProductScreenVendor> createState() => _AddProductScreenVendorState();
}

class _AddProductScreenVendorState extends State<AddProductScreenVendor> {
  final proName = TextEditingController();
  final proPrice = TextEditingController();
  final proDesc = TextEditingController();
  final proCategory = TextEditingController();
  final proQuantity = TextEditingController();
  final createCategory = TextEditingController();

  var email;
  var token;
  var fullName;

  late String userId;
  String base64Image = "";
  Uint8List? image;
  String mimeType = "";

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      mimeType = lookupMimeType(pickedImage.path) ?? '';
      final imageBytes = await pickedImage.readAsBytes();
      image = await pickedImage.readAsBytes();
      setState(() {
        base64Image = base64Encode(imageBytes);
      });
    }
  }

  Future<void> _uploadDataProduct() async {
    try {
      final response = await AddProductApiVendor.addProduct(
          image,
          mimeType,
          userId,
          proName.text,
          proPrice.text,
          proDesc.text,
          proCategory.text,
          proQuantity.text);
      if (response.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Text(
                  'Product Added',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            duration: Duration(seconds: 1),
            elevation: 10,
            backgroundColor: Color.fromARGB(255, 255, 140, 0),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(5),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error'),
        ),
      );
    }
  }

  Future refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      GetCategory.getCategory();
    });
  }

  void cateCreate() async {
    CreateCategoryApiVendor.createCat(createCategory.text, context);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    GetCategory.getCategory();
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

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final catkey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(width: 20),
              Container(
                height: 50,
                width: 90,
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
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      await _uploadDataProduct();
                    }
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
                    'Add',
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
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _pickImage,
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
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          key: catkey,
                          controller: createCategory,
                          obscureText: false,
                          cursorColor: Colors.blueGrey,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfff65b08)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Create Category',
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 20),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          height: 50,
                          width: 200,
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
                            onPressed: () async {
                              
                                cateCreate();
                              
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
                              'Create Category',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
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
                              ? const Text('Select Category')
                              : Text(proCategory.text),
                          borderRadius: BorderRadius.circular(10),
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfff65b08)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: proName,
                          obscureText: false,
                          cursorColor: Colors.blueGrey,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfff65b08)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Product Name',
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: proPrice,
                          obscureText: false,
                          cursorColor: Colors.blueGrey,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfff65b08)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Product Price',
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: proQuantity,
                          obscureText: false,
                          cursorColor: Colors.blueGrey,
                          cursorHeight: 25,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xfff65b08)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Product Quantity',
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 20),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product quantity';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
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
                              borderSide: BorderSide(
                                  color: Color(0xfff65b08), width: 2),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Product Description',
                            hintStyle: TextStyle(
                                color: Colors.grey[500], fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // uploadUI() {
  //   return Center(
  //     child: MultiImagePicker(
  //       totalImages: 1,
  //       initialValue: const [],
  //       imageSource: ImagePickSource.gallery,
  //       onImageChanged: (image) {
  //         singleimageFile = image[0].imageFile;
  //       },
  //     ),
  //   );
  // }
}
