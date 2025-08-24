// import 'package:get_storage/get_storage.dart';
// import 'package:pet_sense/app/model/user_model.dart';
// import 'package:pet_sense/core/constants.dart';

// class StorageProvider {
//   static final GetStorage _storage = GetStorage();

//   // Token operations
//   static Future<void> saveToken(String token) async {
//     await _storage.write(ApiConstants.tokenKey, token);
//   }

//   static String? getToken() {
//     return _storage.read(ApiConstants.tokenKey);
//   }

//   static Future<void> removeToken() async {
//     await _storage.remove(ApiConstants.tokenKey);
//   }

//   // User operations
//   static Future<void> saveUser(UserModel user) async {
//     await _storage.write(ApiConstants.userKey, user.toJson());
//   }

//   static UserModel? getUser() {
//     final userData = _storage.read(ApiConstants.userKey);
//     if (userData != null) {
//       return UserModel.fromJson(Map<String, dynamic>.from(userData));
//     }
//     return null;
//   }

//   static Future<void> removeUser() async {
//     await _storage.remove(ApiConstants.userKey);
//   }

//   // Login status
//   static Future<void> setLoginStatus(bool isLoggedIn) async {
//     await _storage.write(ApiConstants.isLoggedInKey, isLoggedIn);
//   }

//   static bool getLoginStatus() {
//     return _storage.read(ApiConstants.isLoggedInKey) ?? false;
//   }

//   // Clear all data
//   static Future<void> clearAll() async {
//     await _storage.erase();
//   }

//   // Check if user is authenticated
//   static bool isAuthenticated() {
//     return getToken() != null && getLoginStatus();
//   }
// }