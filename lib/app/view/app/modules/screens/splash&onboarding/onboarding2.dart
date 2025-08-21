import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/login_screen.dart';
import 'package:pet_sense/app/view/app/modules/screens/splash&onboarding/onboarding3.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              // العنوان في الأعلى
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          Get.offAll(() => LoginScreen());
                        },
                        child: Text(
                          'skip'.tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontFamily: GoogleFonts.cairo().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Image.asset('assets/dog1.png', height: 200, width: 115),
                      SizedBox(height: 20),
                      Image.asset('assets/dog2.png', height: 200, width: 115),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 60),
                      Image.asset('assets/cat.png', height: 200, width: 115),
                      SizedBox(height: 20),
                      Image.asset('assets/dog3.png', height: 200, width: 115),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset('assets/dog4.png', height: 200, width: 115),
                      SizedBox(height: 20),
                      Image.asset('assets/dog5.png', height: 200, width: 115),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 20),
              Divider(color: Color(0xff01727A), thickness: 1.5),
              SizedBox(height: 20),
              Text(
                'slogan2'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'sub_slogan2'.tr,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => Onboarding3());
                },
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xff01727A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'next'.tr,
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
