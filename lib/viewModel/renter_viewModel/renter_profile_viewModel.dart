import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  String? _fullName;
  String? _phoneNumber;
  String? _email;
  String? _role;
  String? _area;
  String? _cnic;
  String? id;
  String? profilePicture;
  String? cnicPicture;

  // Getter methods
  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get role => _role;
  String? get area => _area;
  String? get cnic => _cnic;

  // Method to load user data from session
  Future<void> loadUserData() async {
    final userInfo = await SessionManager.getUserInfo();
    _fullName = userInfo['fullName'];
    _phoneNumber = userInfo['phoneNumber'];
    _email = userInfo['email'];
    _role = userInfo['role'];
    _area = userInfo['area'];
    _cnic = userInfo['cnic'];
    profilePicture = userInfo['profilePicture'];

    cnicPicture = userInfo['cnicPicture'];
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Logout functionality
  Future<void> logout(BuildContext context) async {
    await SessionManager.clearSession(); // Clear session data
    Navigator.pushReplacementNamed(
        context, RoutesName.renterLoginScreen); // Navigate to the login screen
  }

  File? image;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }
}
