import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
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

  File? cnicImage;
  final picker = ImagePicker();
  File? profileImage;


    // Pick from gallery for profile
  Future<void> pickProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> cnicPickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      cnicImage = File(pickedFile.path);
    }
  }


Future<void> uploadImages({
  required File? profileImage,
  required File? cnicImage,
  required BuildContext context,
}) async {
  final response = await ApiClient.multipartUpload(
    endpoint: '/api/renter/upload',
    fields: {}, // Add any form fields if needed
    files: {
      'personalPicture': profileImage,
      'cnicPicture': cnicImage,
    },
    isToken: true,
  );

  if (response['success'] == true) {
  HelperFunctions.showSuccessSnackbar(
          context, 'Upload successful');
    
    Navigator.pop(context);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response['message'] ?? 'Upload failed')),
    );
  }
}

}
