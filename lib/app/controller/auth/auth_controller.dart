// register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_sense/app/model/user_model.dart';
import 'package:pet_sense/core/services/auth_services.dart';

enum UserType {
  user(Icons.person, 'Pet Owner', 'مالك حيوان', 'user'),
  doctor(Icons.medical_services, 'Veterinarian', 'طبيب بيطري', 'doctor'),
  petSitter(Icons.pets, 'Pet Sitter', 'راعي حيوانات', 'pet_sitter'),
  petGroomer(
    Icons.cleaning_services,
    'Pet Groomer',
    'مزين حيوانات',
    'pet_groomer',
  );

  const UserType(this.icon, this.englishName, this.arabicName, this.value);

  final IconData icon;
  final String englishName;
  final String arabicName;
  final String value;
}

class RegisterController extends GetxController {
  // Observable variables
  final RxBool isLoading = false.obs;
  final Rx<UserType?> selectedUserType = Rx<UserType?>(null);
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool agreeToTerms = false.obs;

  // Text editing controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController fullNameController =
      TextEditingController(); // Keep for backward compatibility
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Doctor-specific controllers (shown only when doctor is selected)
  final TextEditingController licenseNumberController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController consultationFeeController =
      TextEditingController();
  final TextEditingController bioController = TextEditingController();

  // Specialization for doctors
  final RxList<String> selectedSpecializations = <String>[].obs;
  final List<String> availableSpecializations = [
    'General Practice',
    'Surgery',
    'Internal Medicine',
    'Dermatology',
    'Cardiology',
    'Oncology',
    'Orthopedics',
    'Neurology',
    'Emergency Medicine',
    'Exotic Animals',
    'Large Animals',
    'Small Animals',
  ];

  // Form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    // Dispose all controllers
    firstNameController.dispose();
    lastNameController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    licenseNumberController.dispose();
    experienceController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    consultationFeeController.dispose();
    bioController.dispose();
    super.onClose();
  }

  // UI Actions
  void selectUserType(UserType userType) {
    selectedUserType.value = userType;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms() {
    agreeToTerms.value = !agreeToTerms.value;
  }

  void toggleSpecialization(String specialization) {
    if (selectedSpecializations.contains(specialization)) {
      selectedSpecializations.remove(specialization);
    } else {
      selectedSpecializations.add(specialization);
    }
  }

  // Navigation
  void goToLogin() {
    Get.back();
    // or Get.toNamed('/login');
  }

  void showTermsAndConditions() {
    Get.dialog(
      AlertDialog(
        title: Text('terms_and_conditions'.tr),
        content: SingleChildScrollView(
          child: Text(
            'Here are the terms and conditions...\n\n'
            'By using this app, you agree to our terms of service and privacy policy.',
            style: TextStyle(fontSize: 14),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('close'.tr)),
        ],
      ),
    );
  }

  // Validation methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_required'.tr;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4})$');
    if (!emailRegex.hasMatch(value)) {
      return 'invalid_email'.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_required'.tr;
    }
    if (value.length < 6) {
      return 'password_too_short'.tr;
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'confirm_password_required'.tr;
    }
    if (value != passwordController.text) {
      return 'passwords_dont_match'.tr;
    }
    return null;
  }

  String? validateRequiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName ${'is_required'.tr}';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value != null && value.isNotEmpty) {
      final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{10,15}$');
      if (!phoneRegex.hasMatch(value)) {
        return 'invalid_phone'.tr;
      }
    }
    return null;
  }

  // Main registration method
  Future<void> register() async {
    // Basic validations
    if (selectedUserType.value == null) {
      _showErrorSnackbar('please_select_user_type'.tr);
      return;
    }

    if (!agreeToTerms.value) {
      _showErrorSnackbar('please_agree_terms'.tr);
      return;
    }

    // Validate form
    if (!_validateForm()) {
      return;
    }

    try {
      isLoading.value = true;

      // Create user profile
      final profile = UserProfile(
        firstName: firstNameController.text.trim().isNotEmpty
            ? firstNameController.text.trim()
            : fullNameController.text.trim().split(' ').first,
        lastName: lastNameController.text.trim().isNotEmpty
            ? lastNameController.text.trim()
            : (fullNameController.text.trim().split(' ').length > 1
                  ? fullNameController.text.trim().split(' ').skip(1).join(' ')
                  : ''),
        phone: phoneController.text.trim().isNotEmpty
            ? phoneController.text.trim()
            : null,
      );

      // Create doctor info if user is a doctor
      DoctorInfo? doctorInfo;
      if (selectedUserType.value == UserType.doctor) {
        if (!_validateDoctorFields()) {
          return;
        }

        doctorInfo = DoctorInfo(
          licenseNumber: licenseNumberController.text.trim(),
          specialization: List<String>.from(selectedSpecializations),
          experience: int.parse(experienceController.text.trim()),
          clinicName: clinicNameController.text.trim(),
          clinicAddress: clinicAddressController.text.trim(),
          consultationFee: double.parse(consultationFeeController.text.trim()),
          workingHours: AuthService.getDefaultWorkingHours(),
          bio: bioController.text.trim().isNotEmpty
              ? bioController.text.trim()
              : null,
        );
      }

      // Call API
      final response = await AuthService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text,
        userType: selectedUserType.value!.value,
        profile: profile,
        doctorInfo: doctorInfo,
      );

      if (response.success) {
        _showSuccessSnackbar(response.message);
        Get.snackbar(
          'Account Created',
          'Please check your email to verify your account',
        );

        // Navigate to verification screen
        Get.toNamed(
          '/verify-email',
          arguments: {
            'email': emailController.text.trim(),
            'userType': selectedUserType.value!.value,
          },
        );

        // Clear form
        _clearForm();
      } else {
        _showErrorSnackbar(response.message);
      }
    } catch (e) {
      _showErrorSnackbar('registration_failed'.tr + ': $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Private helper methods
  bool _validateForm() {
    // Basic field validation
    if (firstNameController.text.trim().isEmpty &&
        fullNameController.text.trim().isEmpty) {
      _showErrorSnackbar('name_required'.tr);
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      _showErrorSnackbar('email_required'.tr);
      return false;
    }

    final emailError = validateEmail(emailController.text);
    if (emailError != null) {
      _showErrorSnackbar(emailError);
      return false;
    }

    if (passwordController.text.isEmpty) {
      _showErrorSnackbar('password_required'.tr);
      return false;
    }

    final passwordError = validatePassword(passwordController.text);
    if (passwordError != null) {
      _showErrorSnackbar(passwordError);
      return false;
    }

    if (confirmPasswordController.text.isEmpty) {
      _showErrorSnackbar('confirm_password_required'.tr);
      return false;
    }

    final confirmPasswordError = validateConfirmPassword(
      confirmPasswordController.text,
    );
    if (confirmPasswordError != null) {
      _showErrorSnackbar(confirmPasswordError);
      return false;
    }

    return true;
  }

  bool _validateDoctorFields() {
    if (licenseNumberController.text.trim().isEmpty) {
      _showErrorSnackbar('license_number_required'.tr);
      return false;
    }

    if (experienceController.text.trim().isEmpty) {
      _showErrorSnackbar('experience_required'.tr);
      return false;
    }

    final experience = int.tryParse(experienceController.text.trim());
    if (experience == null || experience < 0) {
      _showErrorSnackbar('invalid_experience'.tr);
      return false;
    }

    if (clinicNameController.text.trim().isEmpty) {
      _showErrorSnackbar('clinic_name_required'.tr);
      return false;
    }

    if (clinicAddressController.text.trim().isEmpty) {
      _showErrorSnackbar('clinic_address_required'.tr);
      return false;
    }

    if (consultationFeeController.text.trim().isEmpty) {
      _showErrorSnackbar('consultation_fee_required'.tr);
      return false;
    }

    final fee = double.tryParse(consultationFeeController.text.trim());
    if (fee == null || fee < 0) {
      _showErrorSnackbar('invalid_consultation_fee'.tr);
      return false;
    }

    if (selectedSpecializations.isEmpty) {
      _showErrorSnackbar('specialization_required'.tr);
      return false;
    }

    return true;
  }

  void _clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    fullNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    phoneController.clear();
    licenseNumberController.clear();
    experienceController.clear();
    clinicNameController.clear();
    clinicAddressController.clear();
    consultationFeeController.clear();
    bioController.clear();

    selectedUserType.value = null;
    selectedSpecializations.clear();
    agreeToTerms.value = false;
    isPasswordVisible.value = false;
    isConfirmPasswordVisible.value = false;
  }

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
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }

  // Check if should show doctor fields
  bool get shouldShowDoctorFields => selectedUserType.value == UserType.doctor;

  // Get display name for selected user type
  String get selectedUserTypeDisplayName {
    if (selectedUserType.value == null) return '';
    return Get.locale?.languageCode == 'ar'
        ? selectedUserType.value!.arabicName
        : selectedUserType.value!.englishName;
  }
}
