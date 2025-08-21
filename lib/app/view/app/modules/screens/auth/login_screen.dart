// pubspec.yaml dependencies needed:
// dependencies:
//   flutter:
//     sdk: flutter
//   get: ^4.6.6
//   google_fonts: ^6.1.0

import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/forget_password_screen.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/register_screen.dart';

// Model
class AuthModel {
  final String email;
  final String password;
  final bool rememberMe;

  AuthModel({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

// Controller

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void forgotPassword() {
    // Get.snackbar(
    //   "نسيت كلمة المرور",
    //   "تم إرسال رابط إعادة تعيين كلمة المرور",
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    Get.to(() => ForgetPassword());
  }

  void login() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "خطأ",
        "يرجى ملء جميع الحقول",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
      );
      return;
    }

    Get.snackbar(
      "تسجيل الدخول",
      "تم تسجيل الدخول بنجاح",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
    );
  }

  void createAccount() {
    // Get.snackbar(
    //   "إنشاء حساب",
    //   "الانتقال إلى صفحة إنشاء حساب",
    //   snackPosition: SnackPosition.BOTTOM,
    // );
    Get.to(RegisterScreen());
  }

  void loginWithFacebook() {
    Get.snackbar(
      "Facebook",
      "تسجيل الدخول بواسطة Facebook",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithGoogle() {
    Get.snackbar(
      "Google",
      "تسجيل الدخول بواسطة Google",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void loginWithApple() {
    Get.snackbar(
      "Apple",
      "تسجيل الدخول بواسطة Apple",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}

// View

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              Row(
                children: [
                  Spacer(),
                  Text(
                    'Pet Sense',
                    style: GoogleFonts.cairo(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xff01727A),
                    ),
                  ),
                  Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              // Logo
              SizedBox(
                child: Center(
                  child: Image.asset(
                    "assets/Frame 361.png",
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),

              // const Spacer(flex: 3),

              // Email Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  cursorColor: Color(0xff01727A),

                  controller: controller.emailController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'enter_email'.tr,
                    labelStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: Color(0xFF2D9596),
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    cursorColor: Color(0xff01727A),
                    controller: controller.passwordController,
                    textAlign: TextAlign.right,
                    obscureText: !controller.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'enter_password'.tr,
                      labelStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Color(0xff01727A),
                          width: 1,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: controller.forgotPassword,
                    child: Text(
                      'forgot_password'.tr,
                      style: TextStyle(
                        color: Color(0xff01727A),
                        fontSize: 14,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'remember_me'.tr,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff01727A),
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(
                        () => SizedBox(
                          width: 20,
                          height: 20,
                          child: Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: (value) => controller.toggleRememberMe(),
                            activeColor: const Color(0xff01727A),

                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff01727A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'login'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Create Account Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: controller.createAccount,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF374151),
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'signup'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff01727A),
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Divider with "أو من خلال"
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or_continue_with'.tr,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ),

              const SizedBox(height: 24),

              // Social Login Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Facebook
                  GestureDetector(
                    onTap: controller.loginWithFacebook,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1877F2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.facebook,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),

                  // Google
                  GestureDetector(
                    onTap: controller.loginWithGoogle,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Text(
                          'G',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF4285F4),
                            fontFamily: GoogleFonts.cairo().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Apple
                  GestureDetector(
                    onTap: controller.loginWithApple,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.apple,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
