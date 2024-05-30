// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VendorDetails extends StatefulWidget {
  const VendorDetails({super.key});

  @override
  State<VendorDetails> createState() => _VendorDetailsState();
}

class _VendorDetailsState extends State<VendorDetails> {
  var name;
  var email;

  @override
  void initState() {
    super.initState();

    loadDetails();
  }

  loadDetails() async {
    final prefs = await SharedPreferences.getInstance();

    name = prefs.getString('fullName')!;
    email = prefs.getString('email')!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (name == "" && email == "") {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff65b08),
        toolbarHeight: 60,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xfff65b08),
              ),
              child: Center(
                child: Text(
                  name.toString().characters.first,
                  style: const TextStyle(fontSize: 100),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              name,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              email,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
