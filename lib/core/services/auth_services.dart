import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_sense/app/model/api_response_model.dart';
import 'package:pet_sense/app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // Replace with your actual backend URL
  // For real device testing, use your local IP address or deployed URL
  static const String baseUrl = 'http://192.168.1.3:3000/api/auth';

  // Headers for API requests
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  // Sign up method - Updated to support both user and doctor registration
  static Future<ApiResponse> signUp({
    required String email,
    required String password,
    required String userType, // "user" or "doctor"
    required UserProfile profile,
    UserLocation? location,
    DoctorInfo? doctorInfo, // Required if userType is "doctor"
  }) async {
    try {
      // Validate doctor requirements
      if (userType == 'doctor' && doctorInfo == null) {
        return ApiResponse(
          success: false,
          message: 'Doctor information is required for doctor accounts',
        );
      }

      final requestBody = {
        'email': email.toLowerCase().trim(),
        'password': password,
        'userType': userType,
        'profile': profile.toJson(),
        if (location != null) 'location': location.toJson(),
        if (doctorInfo != null) 'doctorInfo': doctorInfo.toJson(),
      };

      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: headers,
        body: json.encode(requestBody),
      );
      print('bodddddddddddddddddddddddy ${response.body}');

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200|| response.statusCode == 201) {
        // Updated status code
        return ApiResponse(
          success: true,
          message: data['message'],
          data: {
            'userType': data['userType'],
            'verificationCode':
                data['verificationCode'], // For development only
            'email': email,
          },
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['error'] ?? 'Signup failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Login method - remains the same but now returns enhanced user data
  static Future<ApiResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers,
        body: json.encode({
          'email': email.toLowerCase().trim(),
          'password': password,
        }),
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        // Store token in SharedPreferences
        await _storeToken(data['token']);

        // Create User object with enhanced data
        final user = User.fromJson(data['user']);

        return ApiResponse(
          success: true,
          message: 'Login successful',
          data: {'token': data['token'], 'user': user},
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['error'] ?? 'Login failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Email verification method - remains the same but returns enhanced user data
  static Future<ApiResponse> verifyEmail({
    required String email,
    required String code,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/verify'),
        headers: headers,
        body: json.encode({'email': email.toLowerCase().trim(), 'code': code}),
      );

      final Map<String, dynamic> data = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = User.fromJson(data['user']);

        return ApiResponse(
          success: true,
          message: data['message'],
          data: {'user': user},
        );
      } else {
        return ApiResponse(
          success: false,
          message: data['error'] ?? 'Verification failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Network error: ${e.toString()}',
      );
    }
  }

  // Store token in SharedPreferences
  static Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Get stored token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Store user data in SharedPreferences
  static Future<void> storeUserData(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_data', json.encode(user.toJson()));
  }

  // Get stored user data
  static Future<User?> getStoredUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      try {
        final userData = json.decode(userDataString);
        return User.fromJson(userData);
      } catch (e) {
        print('Error parsing stored user data: $e');
        return null;
      }
    }
    return null;
  }

  // Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Logout - clear stored token and user data
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
  }

  // Get authorization headers for authenticated requests
  static Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // Make authenticated request
  static Future<http.Response> authenticatedRequest({
    required String endpoint,
    required String method,
    Map<String, dynamic>? body,
  }) async {
    final headers = await getAuthHeaders();
    final uri = Uri.parse('$baseUrl$endpoint');

    switch (method.toUpperCase()) {
      case 'GET':
        return await http.get(uri, headers: headers);
      case 'POST':
        return await http.post(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'PUT':
        return await http.put(
          uri,
          headers: headers,
          body: body != null ? json.encode(body) : null,
        );
      case 'DELETE':
        return await http.delete(uri, headers: headers);
      default:
        throw Exception('Unsupported HTTP method: $method');
    }
  }

  // Helper method to create default working hours for doctors
  static List<WorkingHours> getDefaultWorkingHours() {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    return days
        .map(
          (day) => WorkingHours(
            day: day,
            startTime: '09:00',
            endTime: '17:00',
            isAvailable: true,
          ),
        )
        .toList();
  }
}
