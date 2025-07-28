import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/core/utlis/validator.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProfileVM =
        Provider.of<UserProfileViewModel>(context, listen: false);

    final oldPasswordVisible = ValueNotifier<bool>(false);
    final newPasswordVisible = ValueNotifier<bool>(false);
    final confirmPasswordVisible = ValueNotifier<bool>(false);

    final formKey = GlobalKey<FormState>();

    final oldPassController = TextEditingController();
    final newPassemailController = TextEditingController();
    final confirmPassemailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _PasswordLabel("Old Password"),
                const SizedBox(height: 8),
                _PasswordField(
                  hintText: "Enter old password",
                  isVisibleNotifier: oldPasswordVisible,
                  validation_text: "Old Password is required",
                  customValidator: Validator.validatePassword,
                  controller: oldPassController,
                ),
                const SizedBox(height: 24),
                const _PasswordLabel("New Password"),
                const SizedBox(height: 8),
                _PasswordField(
                  controller: newPassemailController,
                  hintText: "Enter new password",
                  isVisibleNotifier: newPasswordVisible,
                  validation_text: "Password is required",
                  customValidator: Validator.validatePassword,
                ),
                const SizedBox(height: 24),
                const _PasswordLabel("Confirm Password"),
                const SizedBox(height: 8),
                _PasswordField(
                  controller: confirmPassemailController,
                  validation_text: "Confirm Password is required",
                  customValidator: (value) => Validator.validateConfirmPassword(
                      value, newPassemailController.text),
                  hintText: "Re-enter new password",
                  isVisibleNotifier: confirmPasswordVisible,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                userProfileVM.changePassword(
                    currentPassword: oldPassController.text.trim(),
                    newPassword: confirmPassemailController.text.trim(),
                    context: context);
                // All fields are valid
                // Perform change password logic
              }
            },
            child: const Text(
              'Change Password',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordLabel extends StatelessWidget {
  final String label;
  const _PasswordLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final String hintText, validation_text;
  final ValueNotifier<bool> isVisibleNotifier;
  final FormFieldValidator<String>? customValidator;
  final TextEditingController controller;

  const _PasswordField({
    required this.hintText,
    required this.isVisibleNotifier,
    required this.validation_text,
    this.customValidator,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isVisibleNotifier,
      builder: (context, isVisible, _) {
        return TextFormField(
          controller: controller,
          obscureText: !isVisible,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.blue,
              ),
              onPressed: () => isVisibleNotifier.value = !isVisible,
            ),
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return validation_text;
            }
            if (customValidator != null) {
              return customValidator!(
                  value); // Use the custom validator if provided
            }
            return null;
          },
        );
      },
    );
  }
}
              // const SizedBox(height: 20),
              // Text("Password Requirements:", style: TextStyle(fontWeight: FontWeight.bold)),
              // Text("• At least 8 characters\n• Capital letter\n• Contains digit\n• Contains special character"),
              // const SizedBox(height: 20),
