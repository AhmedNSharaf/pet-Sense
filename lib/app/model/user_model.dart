class UserModel {
  final String id;
  final String email;
  final bool verified;

  UserModel({
    required this.id,
    required this.email,
    required this.verified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'verified': verified,
    };
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, verified: $verified)';
  }
}