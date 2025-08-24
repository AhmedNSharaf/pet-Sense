// register_screen.dart
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../../controller/auth/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RegisterController controller = Get.put(RegisterController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xff01727A)),
          onPressed: controller.goToLogin,
        ),
        title: Text(
          'create_new_account'.tr,
          style: TextStyle(
            color: const Color(0xff01727A),
            fontFamily: GoogleFonts.cairo().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff01727A),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Center(
                      child: Image.asset(
                        "assets/Frame 361.png",
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // User Type Selection
                    _buildUserTypeSelection(controller),

                    const SizedBox(height: 20),

                    // Basic Information Section
                    _buildBasicInfoSection(controller),

                    // Doctor-specific fields (shown only for doctors)
                    Obx(() => controller.shouldShowDoctorFields
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              _buildDoctorInfoSection(controller),
                            ],
                          )
                        : const SizedBox()),

                    const SizedBox(height: 20),

                    // Terms and Conditions
                    _buildTermsAndConditions(controller),

                    const SizedBox(height: 20),

                    // Register Button
                    _buildRegisterButton(controller),

                    const SizedBox(height: 20),

                    // Login Link
                    _buildLoginLink(controller),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
      ),
    );
  }

  Widget _buildUserTypeSelection(RegisterController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'select_user_type'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xff01727A),
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: UserType.values.length,
              itemBuilder: (context, index) {
                final userType = UserType.values[index];
                return Obx(
                  () => GestureDetector(
                    onTap: () => controller.selectUserType(userType),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: controller.selectedUserType.value == userType
                            ? const Color(0xff01727A).withOpacity(0.1)
                            : Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.selectedUserType.value == userType
                              ? const Color(0xff01727A)
                              : Colors.grey.shade300,
                          width: controller.selectedUserType.value == userType ? 2 : 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              userType.icon,
                              size: 24,
                              color: controller.selectedUserType.value == userType
                                  ? const Color(0xff01727A)
                                  : Colors.grey.shade600,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              Get.locale?.languageCode == 'ar'
                                  ? userType.arabicName
                                  : userType.englishName,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: controller.selectedUserType.value == userType
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: controller.selectedUserType.value == userType
                                    ? const Color(0xff01727A)
                                    : Colors.grey.shade700,
                                fontFamily: GoogleFonts.cairo().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoSection(RegisterController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'basic_information'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xff01727A),
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
            ),
            const SizedBox(height: 16),

            // First Name
            _buildTextField(
              controller: controller.firstNameController,
              labelText: 'first_name'.tr,
              icon: Icons.person,
            ),

            const SizedBox(height: 12),

            // Last Name
            _buildTextField(
              controller: controller.lastNameController,
              labelText: 'last_name'.tr,
              icon: Icons.person,
            ),

            const SizedBox(height: 12),

            // Email
            _buildTextField(
              controller: controller.emailController,
              labelText: 'email'.tr,
              icon: Icons.email,
              keyboardType: TextInputType.emailAddress,
            ),

            const SizedBox(height: 12),

            // Phone (Optional)
            _buildTextField(
              controller: controller.phoneController,
              labelText: '${'phone'.tr} (${'optional'.tr})',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),

            const SizedBox(height: 12),

            // Password
            Obx(
              () => _buildTextField(
                controller: controller.passwordController,
                labelText: 'password'.tr,
                icon: Icons.lock,
                isPassword: true,
                isPasswordVisible: controller.isPasswordVisible.value,
                onTogglePassword: controller.togglePasswordVisibility,
              ),
            ),

            const SizedBox(height: 12),

            // Confirm Password
            Obx(
              () => _buildTextField(
                controller: controller.confirmPasswordController,
                labelText: 'confirm_password'.tr,
                icon: Icons.lock,
                isPassword: true,
                isPasswordVisible: controller.isConfirmPasswordVisible.value,
                onTogglePassword: controller.toggleConfirmPasswordVisibility,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfoSection(RegisterController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'doctor_information'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xff01727A),
                fontFamily: GoogleFonts.cairo().fontFamily,
              ),
            ),
            const SizedBox(height: 16),

            // License Number
            _buildTextField(
              controller: controller.licenseNumberController,
              labelText: 'license_number'.tr,
              icon: Icons.badge,
            ),

            const SizedBox(height: 12),

            // Experience
            _buildTextField(
              controller: controller.experienceController,
              labelText: 'experience_years'.tr,
              icon: Icons.work,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 12),

            // Clinic Name
            _buildTextField(
              controller: controller.clinicNameController,
              labelText: 'clinic_name'.tr,
              icon: Icons.local_hospital,
            ),

            const SizedBox(height: 12),

            // Clinic Address
            _buildTextField(
              controller: controller.clinicAddressController,
              labelText: 'clinic_address'.tr,
              icon: Icons.location_on,
            ),

            const SizedBox(height: 12),

            // Consultation Fee
            _buildTextField(
              controller: controller.consultationFeeController,
              labelText: 'consultation_fee'.tr,
              icon: Icons.attach_money,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            // Specializations
            _buildSpecializationSection(controller),

            const SizedBox(height: 12),

            // Bio (Optional)
            _buildTextField(
              controller: controller.bioController,
              labelText: '${'bio'.tr} (${'optional'.tr})',
              icon: Icons.description,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecializationSection(RegisterController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'specializations'.tr,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xff01727A),
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.availableSpecializations.map((specialization) {
            return Obx(() {
              final isSelected = controller.selectedSpecializations.contains(specialization);
              return FilterChip(
                label: Text(
                  specialization,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xff01727A),
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
                selected: isSelected,
                onSelected: (selected) => controller.toggleSpecialization(specialization),
                backgroundColor: Colors.grey.shade100,
                selectedColor: const Color(0xff01727A),
                checkmarkColor: Colors.white,
              );
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    TextInputType? keyboardType,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword ? !isPasswordVisible : false,
      maxLines: isPassword ? 1 : maxLines,
      cursorColor: const Color(0xff01727A),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: const Color(0xff01727A)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey.shade600,
                ),
                onPressed: onTogglePassword,
              )
            : null,
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
          fontFamily: GoogleFonts.cairo().fontFamily,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xff01727A), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _buildTermsAndConditions(RegisterController controller) {
    return Row(
      children: [
        Obx(
          () => Checkbox(
            value: controller.agreeToTerms.value,
            onChanged: (value) => controller.toggleAgreeToTerms(),
            activeColor: const Color(0xff01727A),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Text(
                'agree_on'.tr,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontFamily: GoogleFonts.cairo().fontFamily,
                ),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: controller.showTermsAndConditions,
                child: Text(
                  'terms_and_conditions'.tr,
                  style: TextStyle(
                    color: const Color(0xff01727A),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton(RegisterController controller) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: controller.isLoading.value ? null : controller.register,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff01727A),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBackgroundColor: Colors.grey.shade400,
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  'signup'.tr,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    fontFamily: GoogleFonts.cairo().fontFamily,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildLoginLink(RegisterController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'have_account'.tr,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 16,
            fontFamily: GoogleFonts.cairo().fontFamily,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: controller.goToLogin,
          child: Text(
            'login'.tr,
            style: TextStyle(
              color: const Color(0xff01727A),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.cairo().fontFamily,
            ),
          ),
        ),
      ],
    );
  }
}