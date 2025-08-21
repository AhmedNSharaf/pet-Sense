import 'package:pet_sense/app/controller/storage_provider.dart';
import 'package:pet_sense/app/model/api_response_model.dart';
import 'package:pet_sense/app/model/auth_response_model.dart';
import 'package:pet_sense/core/constants.dart';

import '../../app/controller/api_provider.dart';

class AuthService {
  // Sign up user
  static Future<ApiResponseModel<AuthResponseModel>> signup({
    required String email,
    required String password,
  }) async {
    final response = await ApiProvider.post<AuthResponseModel>(
      endpoint: ApiConstants.signup,
      body: {
        'email': email,
        'password': password,
      },
      fromJson: (json) => AuthResponseModel.fromJson(json),
    );

    return response;
  }

  // Login user
  static Future<ApiResponseModel<AuthResponseModel>> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiProvider.post<AuthResponseModel>(
      endpoint: ApiConstants.login,
      body: {
        'email': email,
        'password': password,
      },
      fromJson: (json) => AuthResponseModel.fromJson(json),
    );

    // Save token and user data if login successful
    if (response.success && response.data != null) {
      final authData = response.data!;
      if (authData.token != null) {
        await StorageProvider.saveToken(authData.token!);
        await StorageProvider.setLoginStatus(true);
      }
      if (authData.user != null) {
        await StorageProvider.saveUser(authData.user!);
      }
    }

    return response;
  }

  // Verify email
  static Future<ApiResponseModel<AuthResponseModel>> verifyEmail({
    required String email,
    required String code,
  }) async {
    final response = await ApiProvider.post<AuthResponseModel>(
      endpoint: ApiConstants.verify,
      body: {
        'email': email,
        'code': code,
      },
      fromJson: (json) => AuthResponseModel.fromJson(json),
    );

    // Update user data if verification successful
    if (response.success && response.data?.user != null) {
      await StorageProvider.saveUser(response.data!.user!);
    }

    return response;
  }

  // Logout user
  static Future<void> logout() async {
    await StorageProvider.clearAll();
  }

  // Check if user is authenticated
  static bool isAuthenticated() {
    return StorageProvider.isAuthenticated();
  }

  // Get current user
  static getCurrentUser() {
    return StorageProvider.getUser();
  }

  // Get current token
  static String? getCurrentToken() {
    return StorageProvider.getToken();
  }
}