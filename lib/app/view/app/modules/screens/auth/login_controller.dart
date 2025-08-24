// login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/model/user_model.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/forget_password_screen.dart';
import 'package:pet_sense/app/view/app/modules/screens/auth/register_screen.dart';
import 'package:pet_sense/app/view/app/modules/screens/home/home_screen.dart';
import 'package:pet_sense/core/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;

  // Text editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    // Load remembered credentials if any
    _loadRememberedCredentials();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // UI Actions
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  // Navigation methods
  void forgotPassword() {
    Get.to(() => forgotPassword());
  }

  void createAccount() {
    Get.to(() => RegisterScreen());
  }

  // Social login methods (placeholder implementations)
  Future<void> loginWithFacebook() async {
    _showInfoSnackbar('Facebook login feature coming soon!');
  }

  Future<void> loginWithGoogle() async {
    _showInfoSnackbar('Google login feature coming soon!');
  }

  Future<void> loginWithApple() async {
    _showInfoSnackbar('Apple login feature coming soon!');
  }

  // Main login method
  Future<void> login() async {
    // Basic validation
    if (!_validateForm()) {
      return;
    }

    try {
      isLoading.value = true;

      // Call API
      final response = await AuthService.login(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (response.success) {
        // Extract user data from response
        final user = response.data['user'] as User;
        final token = response.data['token'] as String;
        await saveToken(token);
        print(token);

        // Store user data locally
        await AuthService.storeUserData(user);

        // Show success message
        _showSuccessSnackbar('welcome_back'.tr + ' ${user.profile.firstName}!');

        // Save credentials if remember me is checked
        if (rememberMe.value) {
          await _saveCredentials();
        } else {
          await _clearSavedCredentials();
        }

        // Navigate to home screen
        Get.offAll(() => HomeScreen());

        // Clear form
        _clearForm();
      } else {
        // Handle different error cases
        switch (response.statusCode) {
          case 400:
            _showErrorSnackbar('invalid_input'.tr);
            break;
          case 401:
            if (response.message.contains('verify')) {
              _showErrorSnackbar('please_verify_email'.tr);
              // Optionally navigate to verification screen
            } else {
              _showErrorSnackbar('invalid_credentials'.tr);
            }
            break;
          case 500:
            _showErrorSnackbar('server_error'.tr);
            break;
          default:
            _showErrorSnackbar(response.message);
        }
      }
    } catch (e) {
      _showErrorSnackbar('login_failed'.tr + ': $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Private helper methods
  bool _validateForm() {
    if (emailController.text.trim().isEmpty) {
      _showErrorSnackbar('email_required'.tr);
      return false;
    }

    final emailError = _validateEmail(emailController.text);
    if (emailError != null) {
      _showErrorSnackbar(emailError);
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showErrorSnackbar('password_required'.tr);
      return false;
    }

    return true;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'invalid_email'.tr;
    }
    return null;
  }

  void _clearForm() {
    if (!rememberMe.value) {
      emailController.clear();
      passwordController.clear();
    }
    isPasswordVisible.value = false;
  }

  // Remember credentials functionality
  Future<void> _loadRememberedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedEmail = prefs.getString('remembered_email');
      final savedPassword = prefs.getString('remembered_password');
      final wasRemembered = prefs.getBool('remember_me') ?? false;

      if (wasRemembered && savedEmail != null && savedPassword != null) {
        emailController.text = savedEmail;
        passwordController.text = savedPassword;
        rememberMe.value = true;
      }
    } catch (e) {
      print('Error loading remembered credentials: $e');
    }
  }

  Future<void> _saveCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('remembered_email', emailController.text.trim());
      await prefs.setString('remembered_password', passwordController.text);
      await prefs.setBool('remember_me', true);
    } catch (e) {
      print('Error saving credentials: $e');
    }
  }

  Future<void> _clearSavedCredentials() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('remembered_email');
      await prefs.remove('remembered_password');
      await prefs.setBool('remember_me', false);
    } catch (e) {
      print('Error clearing saved credentials: $e');
    }
  }

  // Snackbar helpers
  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'success'.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'error'.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 4),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  void _showInfoSnackbar(String message) {
    Get.snackbar(
      'info'.tr,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue.withOpacity(0.8),
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.info, color: Colors.white),
    );
  }

  // Check if user should stay logged in
  Future<bool> checkAutoLogin() async {
    try {
      final isLoggedIn = await AuthService.isLoggedIn();
      if (isLoggedIn) {
        final userData = await AuthService.getStoredUserData();
        if (userData != null) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // create function to save token
  Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('token', token);
  }
}
