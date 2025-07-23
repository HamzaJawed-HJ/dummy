import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordVisible = ValueNotifier<bool>(false);
    final newPasswordVisible = ValueNotifier<bool>(false);
    final confirmPasswordVisible = ValueNotifier<bool>(false);

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _PasswordLabel("Old Password"),
              const SizedBox(height: 8),
              _PasswordField(
                hintText: "Enter old password",
                isVisibleNotifier: oldPasswordVisible,
              ),
              const SizedBox(height: 24),
              const _PasswordLabel("New Password"),
              const SizedBox(height: 8),
              _PasswordField(
                hintText: "Enter new password",
                isVisibleNotifier: newPasswordVisible,
              ),
              const SizedBox(height: 24),
              const _PasswordLabel("Confirm Password"),
              const SizedBox(height: 8),
              _PasswordField(
                hintText: "Re-enter new password",
                isVisibleNotifier: confirmPasswordVisible,
              ),
            ],
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
              // handle change password
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
  final String hintText;
  final ValueNotifier<bool> isVisibleNotifier;

  const _PasswordField({
    required this.hintText,
    required this.isVisibleNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isVisibleNotifier,
      builder: (context, isVisible, _) {
        return TextFormField(
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
        );
      },
    );
  }
}
              // const SizedBox(height: 20),
              // Text("Password Requirements:", style: TextStyle(fontWeight: FontWeight.bold)),
              // Text("• At least 8 characters\n• Capital letter\n• Contains digit\n• Contains special character"),
              // const SizedBox(height: 20),
