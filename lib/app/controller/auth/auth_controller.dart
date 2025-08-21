import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/model/user_model.dart';
import 'package:pet_sense/core/constants.dart';
import 'package:pet_sense/core/routes/app_routes.dart';
import 'package:pet_sense/core/services/auth_services.dart';

class AuthController extends GetxController {
  // Reactive variables
  final _isLoading = false.obs;
  final _currentUser = Rx<UserModel?>(null);
  final _isAuthenticated = false.obs;

  // Form controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final verificationCodeController = TextEditingController();

  // Form keys
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();
  final verificationFormKey = GlobalKey<FormState>();

  // Getters
  bool get isLoading => _isLoading.value;
  UserModel? get currentUser => _currentUser.value;
  bool get isAuthenticated => _isAuthenticated.value;

  @override
  void onInit() {
    super.onInit();
    checkAuthStatus();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    verificationCodeController.dispose();
    super.onClose();
  }

  // Check authentication status
  void checkAuthStatus() {
    _isAuthenticated.value = AuthService.isAuthenticated();
    _currentUser.value = AuthService.getCurrentUser();
    
    if (_isAuthenticated.value) {
      // Navigate to main app if already authenticated
      Get.offAllNamed(AppRoutes.home);
    }
  }

  // Sign up
  Future<void> signup() async {
    if (!signupFormKey.currentState!.validate()) return;

    try {
      _isLoading.value = true;
      
      final response = await AuthService.signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.success) {
        AppUtils.showSuccess(response.message);
        
        // Navigate to verification screen
        Get.toNamed(
          AppRoutes.verification,
          arguments: {
            'email': emailController.text.trim(),
            'verificationCode': response.data?.verificationCode,
          },
        );
        
        clearControllers();
      } else {
        AppUtils.showError(response.message);
      }
    } catch (e) {
      AppUtils.showError('Signup failed: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Login
  Future<void> login() async {
    if (!loginFormKey.currentState!.validate()) return;

    try {
      _isLoading.value = true;
      
      final response = await AuthService.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response.success && response.data != null) {
        _isAuthenticated.value = true;
        _currentUser.value = response.data!.user;
        
        AppUtils.showSuccess('Login successful!');
        
        // Navigate to main app
        Get.offAllNamed(AppRoutes.home);
        
        clearControllers();
      } else {
        AppUtils.showError(response.message);
      }
    } catch (e) {
      AppUtils.showError('Login failed: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Verify email
  Future<void> verifyEmail(String email) async {
    if (!verificationFormKey.currentState!.validate()) return;

    try {
      _isLoading.value = true;
      
      final response = await AuthService.verifyEmail(
        email: email,
        code: verificationCodeController.text.trim(),
      );

      if (response.success) {
        _currentUser.value = response.data?.user;
        
        AppUtils.showSuccess('Email verified successfully!');
        
        // Navigate to login screen
        Get.offAllNamed(AppRoutes.login);
        
        clearControllers();
      } else {
        AppUtils.showError(response.message);
      }
    } catch (e) {
      AppUtils.showError('Verification failed: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      _isLoading.value = true;
      
      await AuthService.logout();
      
      _isAuthenticated.value = false;
      _currentUser.value = null;
      
      AppUtils.showSuccess('Logged out successfully!');
      
      // Navigate to login screen
      Get.offAllNamed(AppRoutes.login);
      
      clearControllers();
    } catch (e) {
      AppUtils.showError('Logout failed: ${e.toString()}');
    } finally {
      _isLoading.value = false;
    }
  }

  // Clear form controllers
  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    verificationCodeController.clear();
  }

  // Form validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!AppUtils.isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (!AppUtils.isValidPassword(value)) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? verificationCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Verification code is required';
    }
    if (value.length != 6) {
      return 'Verification code must be 6 digits';
    }
    if (!RegExp(r'^\d{6}$').hasMatch(value)) {
      return 'Verification code must contain only numbers';
    }
    return null;
  }
}