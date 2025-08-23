// register_screen.dart
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pet_sense/app/controller/auth/register_controller.dart';


// Model
class RegisterModel {
  final String fullName;
  final String email;
  final String password;
  final String confirmPassword;
  final UserType? userType;
  final bool agreeToTerms;

  RegisterModel({
    required this.fullName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.userType,
    required this.agreeToTerms,
  });
}

// View
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff01727A)),
          onPressed: controller.goToLogin,
        ),
        title: Text(
          'create_new_account'.tr,
          style: TextStyle(
            color: const Color(0xff01727A),
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Logo
              SizedBox(
                child: Center(
                  child: Image.asset(
                    "assets/Frame 361.png",
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  ),
                ),
              ),

              // User Type Selection
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
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'select_user_type'.tr,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff01727A),
                          fontFamily: GoogleFonts.cairo().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // User Type Grid
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: UserType.values.length,
                        itemBuilder: (context, index) {
                          final userType = UserType.values[index];
                          return Obx(
                            () => GestureDetector(
                              onTap: () => controller.selectUserType(userType),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      controller.selectedUserType.value ==
                                          userType
                                      ? const Color(0xff01727A).withOpacity(0.1)
                                      : Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        controller.selectedUserType.value ==
                                            userType
                                        ? const Color(0xff01727A)
                                        : Colors.grey.shade300,
                                    width:
                                        controller.selectedUserType.value ==
                                            userType
                                        ? 2
                                        : 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        userType.icon,
                                        size: 20,
                                        color:
                                            controller.selectedUserType.value ==
                                                userType
                                            ? const Color(0xff01727A)
                                            : Colors.grey.shade600,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        Get.locale?.languageCode == 'ar'
                                            ? userType.arabicName
                                            : userType.englishName,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight:
                                              controller
                                                      .selectedUserType
                                                      .value ==
                                                  userType
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color:
                                              controller
                                                      .selectedUserType
                                                      .value ==
                                                  userType
                                              ? const Color(0xff01727A)
                                              : Colors.grey.shade700,
                                          fontFamily:
                                              GoogleFonts.cairo().fontFamily,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Full Name Field
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

                  controller: controller.fullNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    labelText: 'full_name'.tr,
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

              const SizedBox(height: 10),

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
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'email'.tr,
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

              const SizedBox(height: 10),

              // Password Field
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
                      labelText: 'password'.tr,
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

              const SizedBox(height: 10),

              // Confirm Password Field
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

                    controller: controller.confirmPasswordController,
                    textAlign: TextAlign.right,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'confirm_password'.tr,
                      labelStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 16,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
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

              const SizedBox(height: 20),

              // Terms and Conditions
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => SizedBox(
                      width: 20,
                      height: 20,
                      child: Checkbox(
                        value: controller.agreeToTerms.value,
                        onChanged: (value) => controller.toggleAgreeToTerms(),
                        activeColor: const Color(0xff01727A),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'agree_on'.tr,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: controller.showTermsAndConditions,
                    child: Text(
                      'terms_and_conditions'.tr,
                      style: TextStyle(
                        color: const Color(0xff01727A),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Register Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff01727A),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'signup'.tr,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // // Divider with "أو من خلال"
              // Row(
              //   children: [
              //     Expanded(child: Divider(color: Colors.grey.shade300)),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16),
              //       child: Text(
              //         'or_continue_with'.tr,
              //         style: TextStyle(
              //           color: Colors.grey.shade600,
              //           fontSize: 14,
              //           fontFamily: GoogleFonts.cairo().fontFamily,
              //         ),
              //       ),
              //     ),
              //     Expanded(child: Divider(color: Colors.grey.shade300)),
              //   ],
              // ),

              // const SizedBox(height: 20),

              // // Social Register Buttons
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     // Facebook
              //     GestureDetector(
              //       onTap: controller.registerWithFacebook,
              //       child: Container(
              //         width: 50,
              //         height: 50,
              //         decoration: const BoxDecoration(
              //           color: Color(0xFF1877F2),
              //           shape: BoxShape.circle,
              //         ),
              //         child: const Icon(
              //           Icons.facebook,
              //           color: Colors.white,
              //           size: 28,
              //         ),
              //       ),
              //     ),

              //     // Google
              //     GestureDetector(
              //       onTap: controller.registerWithGoogle,
              //       child: Container(
              //         width: 50,
              //         height: 50,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           shape: BoxShape.circle,
              //           border: Border.all(color: Colors.grey.shade300),
              //         ),
              //         child: Center(
              //           child: Text(
              //             'G',
              //             style: TextStyle(
              //               fontSize: 22,
              //               fontWeight: FontWeight.bold,
              //               color: const Color(0xFF4285F4),
              //               fontFamily: GoogleFonts.cairo().fontFamily,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),

              //     // Apple
              //     GestureDetector(
              //       onTap: controller.registerWithApple,
              //       child: Container(
              //         width: 50,
              //         height: 50,
              //         decoration: const BoxDecoration(
              //           color: Colors.black,
              //           shape: BoxShape.circle,
              //         ),
              //         child: const Icon(
              //           Icons.apple,
              //           color: Colors.white,
              //           size: 28,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 30),

              // Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: controller.goToLogin,
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                        color: const Color(0xff01727A),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.cairo().fontFamily,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'have_account'.tr,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 16,
                      fontFamily: GoogleFonts.cairo().fontFamily,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
