import 'package:canteenflutter/api/user-side-api/auth_api.dart';
import 'package:canteenflutter/constants/image_string.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreenUser extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final email;
  const OtpScreenUser({Key? key, @required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final otpController = TextEditingController();
  
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 841.21,
          width: 410.5,
          color: const Color(0xfff65b08),
          child: Column(
            children: [
              const SizedBox(height: 50),
              SizedBox(
                height: 225,
                child: Image.asset(logo),
              ),
              const SizedBox(height: 30),
              Container(
                height: 320,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 15,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25, top: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Otp Verification',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              Text(
                                'Please enter the otp sent on your registered',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'phone number.',
                                style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Pinput(
                      controller: otpController,
                      length: 4,
                      showCursor: true,
                      isCursorAnimationEnabled: false,

                      // pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                      onCompleted: (value) {
                        if (value.isEmpty == false) {
                          AuthUser.verifyOtpUserSide(email, value, context);
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    // SizedBox(
                    //   height: 60,
                    //   width: 300,
                    //   child: ElevatedButton(
                    //     onPressed: () {
                    //       print(otpController);
                    //     },
                    //     child: Text(
                    //       'Sgin Up',
                    //       style: TextStyle(fontSize: 18),
                    //     ),
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Color(0xfff65b08),
                    //       shadowColor: Colors.black,
                    //       elevation: 20,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //   ),
                    // ),
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
