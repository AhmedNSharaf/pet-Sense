import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/login_screen.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              // العنوان في الأعلى
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Image.asset('assets/cat1.png', width: 115)],
                  ),
                  SizedBox(width: 5),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/dog7.png', width: 115),
                      SizedBox(height: 20),
                      Image.asset('assets/dog8.png', width: 115),
                    ],
                  ),
                  SizedBox(width: 5),
                  Column(
                    children: [Image.asset('assets/dog6.png', width: 115)],
                  ),
                ],
              ),

              SizedBox(height: 20),
              Divider(color: Color(0xff01727A), thickness: 1.5),
              SizedBox(height: 20),
              Text(
                'shop_book_consult'.tr,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '',
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
                  Get.offAll(() => LoginScreen());
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
