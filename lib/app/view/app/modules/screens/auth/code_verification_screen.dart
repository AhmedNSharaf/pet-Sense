import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/login_screen.dart';
import 'package:pinput/pinput.dart';

class CodeVerificationScreen extends StatelessWidget {
  const CodeVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 107),
            Text(
              'app_name'.tr,
              style: GoogleFonts.cairo(
                color: const Color(0xff01727A),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 48),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'verify_identity'.tr,
                  style: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'verification_code_resent'.tr,
                  style: GoogleFonts.cairo(fontSize: 14, color: Colors.black),
                ),
              ],
            ),
            const SizedBox(height: 48),

            /// **Verification Code Input Field (Pinput)**
            Center(
              child: Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                showCursor: true,
                pinAnimationType: PinAnimationType.fade,
                defaultPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffD3D3D3),
                    ), // Default border
                    color: Colors.white, // Default background
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xff01727A), // Filled border color
                    ), // Filled border
                    color: const Color(0xff01727A), // Filled background
                  ),
                ),
                followingPinTheme: PinTheme(
                  width: 50,
                  height: 50,
                  textStyle: GoogleFonts.cairo(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffD3D3D3),
                    ), // Empty border
                    color: const Color(0xffF5F5F5), // Empty background
                  ),
                ),
              ),
            ),

            const SizedBox(height: 48),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'code_not_sent'.tr,
                  style: GoogleFonts.cairo(fontSize: 16, color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    // Add resend logic here
                  },
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'resend'.tr,
                      style: GoogleFonts.cairo(
                        fontSize: 16,
                        color: const Color(0xff01727A),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: MaterialButton(
                  color: const Color(0xff01727A),
                  onPressed: () {},
                  child: Text(
                    'verify_identity'.tr,
                    style: GoogleFonts.cairo(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_outlined, color: const Color(0xff01727A)),
                TextButton(
                  onPressed: () {
                    Get.offAll(LoginScreen());
                  },
                  child: Text(
                    'back_to_login'.tr,
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      color: const Color(0xff01727A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
