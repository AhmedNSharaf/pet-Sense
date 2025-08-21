import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/code_verification_screen.dart';
// User Type Enum
enum UserType {
  petSitter(
    'Pet Sitters/Trainers',
    'مربي ومدربي الحيوانات الأليفة',
    Icons.pets,
  ),
  vendor('Vendors/Stores', 'المتاجر والبائعين', Icons.store),
  veterinarian('Veterinarian', 'الطبيب البيطري', Icons.medical_services),
  petOwner('Pet Owner', 'صاحب حيوان أليف', Icons.favorite);

  const UserType(this.englishName, this.arabicName, this.icon);
  final String englishName;
  final String arabicName;
  final IconData icon;
}

// Controller
class RegisterController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var agreeToTerms = false.obs;
  var selectedUserType = Rxn<UserType>();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void selectUserType(UserType type) {
    selectedUserType.value = type;
  }

  void register() {
    // التحقق من أن جميع الحقول مملوءة
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        "خطأ",
        "يرجى ملء جميع الحقول المطلوبة",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // التحقق من اختيار نوع المستخدم
    if (selectedUserType.value == null) {
      Get.snackbar(
        "خطأ",
        "يرجى اختيار نوع المستخدم",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // التحقق من صحة البريد الإلكتروني
    if (!_isValidEmail(emailController.text)) {
      Get.snackbar(
        "خطأ",
        "يرجى إدخال بريد إلكتروني صحيح",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // التحقق من طول كلمة المرور
    if (passwordController.text.length < 6) {
      Get.snackbar(
        "خطأ",
        "كلمة المرور يجب أن تكون 6 أحرف على الأقل",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // التحقق من تطابق كلمات المرور
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "خطأ",
        "كلمة المرور وتأكيد كلمة المرور غير متطابقتين",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // التحقق من الموافقة على الشروط والأحكام
    if (!agreeToTerms.value) {
      Get.snackbar(
        "خطأ",
        "يرجى الموافقة على الشروط والأحكام",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade800,
      );
      return;
    }

    // إذا تم التحقق من جميع البيانات
    Get.snackbar(
      "نجح إنشاء الحساب",
      "تم إنشاء حسابك بنجاح كـ ${selectedUserType.value!.arabicName}",

      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade100,
      colorText: Colors.green.shade800,
    );
    Get.to(CodeVerificationScreen());

    // يمكنك إضافة منطق إنشاء الحساب هنا
    // مثل استدعاء API أو حفظ البيانات مع نوع المستخدم
    print("User Type: ${selectedUserType.value!.englishName}");
  }

  void registerWithFacebook() {
    Get.snackbar(
      "Facebook",
      "إنشاء حساب بواسطة Facebook",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void registerWithGoogle() {
    Get.snackbar(
      "Google",
      "إنشاء حساب بواسطة Google",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void registerWithApple() {
    Get.snackbar(
      "Apple",
      "إنشاء حساب بواسطة Apple",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void goToLogin() {
    Get.back(); // العودة لصفحة تسجيل الدخول
  }

  void showTermsAndConditions() {
    Get.dialog(
      AlertDialog(
        title: Text(
          'الشروط والأحكام',
          style: TextStyle(
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: SingleChildScrollView(
          child: Text(
            'هنا نص الشروط والأحكام...\n\n'
            '1. استخدام التطبيق\n'
            '2. الخصوصية وحماية البيانات\n'
            '3. المسؤوليات\n'
            '4. القوانين المعمول بها\n\n'
            'يرجى قراءة هذه الشروط بعناية قبل الموافقة عليها.',
            style: TextStyle(fontFamily: GoogleFonts.cairo().fontFamily),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'موافق',
              style: TextStyle(
                fontFamily: GoogleFonts.cairo().fontFamily,
                color: const Color(0xff01727A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}

