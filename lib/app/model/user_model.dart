class User {
  final String id;
  final String email;
  final bool verified;
  final String userType; // "user" or "doctor"
  final UserProfile profile;
  final UserLocation? location;
  final DoctorInfo? doctorInfo; // Only for doctors
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    required this.verified,
    required this.userType,
    required this.profile,
    this.location,
    this.doctorInfo,
    this.createdAt,
    this.updatedAt,
  });

  // Create User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? json['_id'] ?? '',
      email: json['email'] ?? '',
      verified: json['verified'] ?? false,
      userType: json['userType'] ?? 'user',
      profile: UserProfile.fromJson(json['profile'] ?? {}),
      location: json['location'] != null ? UserLocation.fromJson(json['location']) : null,
      doctorInfo: json['doctorInfo'] != null ? DoctorInfo.fromJson(json['doctorInfo']) : null,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt']) 
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt']) 
          : null,
    );
  }

  // Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'verified': verified,
      'userType': userType,
      'profile': profile.toJson(),
      'location': location?.toJson(),
      'doctorInfo': doctorInfo?.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // Copy with method for updating user data
  User copyWith({
    String? id,
    String? email,
    bool? verified,
    String? userType,
    UserProfile? profile,
    UserLocation? location,
    DoctorInfo? doctorInfo,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      verified: verified ?? this.verified,
      userType: userType ?? this.userType,
      profile: profile ?? this.profile,
      location: location ?? this.location,
      doctorInfo: doctorInfo ?? this.doctorInfo,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isDoctor => userType == 'doctor';
  bool get isUser => userType == 'user';

  @override
  String toString() {
    return 'User{id: $id, email: $email, verified: $verified, userType: $userType}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class UserProfile {
  final String firstName;
  final String lastName;
  final String? phone;
  final String? avatar;

  UserProfile({
    required this.firstName,
    required this.lastName,
    this.phone,
    this.avatar,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      if (phone != null) 'phone': phone,
      if (avatar != null) 'avatar': avatar,
    };
  }

  String get fullName => '$firstName $lastName';
}

class UserLocation {
  final List<double>? coordinates; // [longitude, latitude]
  final String? address;
  final String? city;
  final String? country;

  UserLocation({
    this.coordinates,
    this.address,
    this.city,
    this.country,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) {
    return UserLocation(
      coordinates: json['coordinates'] != null 
          ? List<double>.from(json['coordinates'].map((x) => x.toDouble()))
          : null,
      address: json['address'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (coordinates != null) 'coordinates': coordinates,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (country != null) 'country': country,
    };
  }
}

class DoctorInfo {
  final String licenseNumber;
  final List<String> specialization;
  final int experience;
  final String clinicName;
  final String clinicAddress;
  final double consultationFee;
  final List<WorkingHours>? workingHours;
  final String? bio;
  final List<String>? education;
  final List<String>? certificates;

  DoctorInfo({
    required this.licenseNumber,
    required this.specialization,
    required this.experience,
    required this.clinicName,
    required this.clinicAddress,
    required this.consultationFee,
    this.workingHours,
    this.bio,
    this.education,
    this.certificates,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      licenseNumber: json['licenseNumber'] ?? '',
      specialization: List<String>.from(json['specialization'] ?? []),
      experience: json['experience'] ?? 0,
      clinicName: json['clinicName'] ?? '',
      clinicAddress: json['clinicAddress'] ?? '',
      consultationFee: (json['consultationFee'] ?? 0).toDouble(),
      workingHours: json['workingHours'] != null
          ? List<WorkingHours>.from(json['workingHours'].map((x) => WorkingHours.fromJson(x)))
          : null,
      bio: json['bio'],
      education: json['education'] != null ? List<String>.from(json['education']) : null,
      certificates: json['certificates'] != null ? List<String>.from(json['certificates']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'licenseNumber': licenseNumber,
      'specialization': specialization,
      'experience': experience,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'consultationFee': consultationFee,
      if (workingHours != null) 'workingHours': workingHours!.map((x) => x.toJson()).toList(),
      if (bio != null) 'bio': bio,
      if (education != null) 'education': education,
      if (certificates != null) 'certificates': certificates,
    };
  }
}

class WorkingHours {
  final String day;
  final String startTime;
  final String endTime;
  final bool isAvailable;

  WorkingHours({
    required this.day,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) {
    return WorkingHours(
      day: json['day'] ?? '',
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      isAvailable: json['isAvailable'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'isAvailable': isAvailable,
    };
  }
}