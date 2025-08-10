import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/models/renter_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OwnerProfileViewModel extends ChangeNotifier {
  String? _fullName;
  String? _phoneNumber;
  String? _email;
  String? _role;
  String? _area;
  String? _cnic;
  String? id;
  String? profilePicture;
  String? cnicPicture;
  String? shopName;
  String? shopAddress;

  // Getter methods
  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get role => _role;
  String? get area => _area;
  String? get cnic => _cnic;

  // Method to load user data from session
  Future<void> loadOwnerData() async {
    final userInfo = await SessionManager.getRenterInfo();
    _fullName = userInfo['fullName'];
    _phoneNumber = userInfo['phoneNumber'];
    _email = userInfo['email'];
    _role = userInfo['role'];
    _area = userInfo['area'];
    _cnic = userInfo['cnic'];
    profilePicture = userInfo['profilePicture'];

    cnicPicture = userInfo['cnicPicture'];
    shopName = userInfo['shopName'];
    shopAddress = userInfo['cnic'];

    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Logout functionality
  // Future<void> logout(BuildContext context) async {
  //     final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('profilePicture', "");
  //   await SessionManager.clearSession(); // Clear session data
  //   Navigator.pushReplacementNamed(
  //       context, RoutesName.renterLoginScreen); // Navigate to the login screen
  // }

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
      endpoint: '/renter/upload',
      fields: {}, // Add any form fields if needed
      files: {
        'personalPicture': profileImage,
        'cnicPicture': cnicImage,
      },
      isToken: true,
    );

    if (response['success'] == true) {
      HelperFunctions.showSuccessSnackbar(context, 'Upload successful');

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Upload failed')),
      );
    }
  }

  Future<void> editProfile({
    required File? profileImage,
    required String fullName,
    required String email,
    required String shopName,
    required String shopAddress,
    required BuildContext context,
  }) async {
    final response = await ApiClient.multipartUpload(
      apiType: "PUT",
      endpoint: '/users/profile/update',
      fields: {
        "fullName": fullName,
        "email": email,
        "shopName": shopName,
        "shopAddress": shopAddress
      }, // Add any form fields if needed
      files: {
        'personalPicture': profileImage,
      },
      isToken: true,
    );

    if (response['success'] == true) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('profilePicture', profileImage?.path ?? "");
      await prefs.setString('fullName', fullName);
      await prefs.setString('email', email);
      await prefs.setString('shopName', shopAddress);
      await prefs.setString('shopAddress', shopAddress);

      await HelperFunctions.showSuccessSnackbar(context, 'Upload successful');

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Upload failed')),
      );
    }
  }

}
