import 'package:pet_sense/app/model/user_model.dart';

class AuthResponseModel {
  final String? token;
  final UserModel? user;
  final String? message;
  final String? verificationCode;

  AuthResponseModel({
    this.token,
    this.user,
    this.message,
    this.verificationCode,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      token: json['token'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      message: json['message'],
      verificationCode: json['verificationCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
      'message': message,
      'verificationCode': verificationCode,
    };
  }
}