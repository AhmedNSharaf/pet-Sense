import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiConstants {
  // Base URL - Replace with your actual API URL
  static const String baseUrl = 'https://pet-sense.vercel.app/api/auth'; // or 'http://localhost:3000' for local dev
  
  // Auth Endpoints
  static const String signup = '/signup';
  static const String login = '/login';
  static const String verify = '/verify';
  
  // Headers
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  
  // Request timeout
  static const Duration timeout = Duration(seconds: 30);
}


class AppValues {
  // Status codes
  static const int success = 200;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int conflict = 409;
  static const int serverError = 500;
  
  // Messages
  static const String networkError = 'Network connection failed';
  static const String serverErrorMessage = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String timeoutError = 'Request timeout';
}
class AppUtils {
  static void showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      backgroundColor: Get.theme.primaryColor,
      colorText: Get.theme.colorScheme.onPrimary,
      duration: const Duration(seconds: 3),
    );
  }
  
  static void showError(String message) {
    Get.snackbar(
      'Error',
      message,
      backgroundColor: Get.theme.colorScheme.error,
      colorText: Get.theme.colorScheme.onError,
      duration: const Duration(seconds: 4),
    );
  }
  
  static void showLoading({String? message}) {
    Get.dialog(
      Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  
  static bool isValidEmail(String email) {
    return GetUtils.isEmail(email);
  }
  
  static bool isValidPassword(String password) {
    return password.length >= 6;
  }
}