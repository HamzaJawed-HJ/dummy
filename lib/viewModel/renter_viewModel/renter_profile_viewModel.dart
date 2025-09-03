import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileViewModel extends ChangeNotifier {
  String? _fullName;
  String? _phoneNumber;
  String? _email;
  String? _role;
  String? _area;
  String? _cnic;
  String? id;
  String profilePicture = '';
  String cnicPicture = '';
  bool isUploaded = false;

  // Getter methods
  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get email => _email;
  String? get role => _role;
  String? get area => _area;
  String? get cnic => _cnic;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  // Method to load user data from session
  Future<void> loadUserData() async {
    final userInfo = await SessionManager.getUserInfo();
    _fullName = userInfo['fullName'];
    _phoneNumber = userInfo['phoneNumber'];
    _email = userInfo['email'];
    _role = userInfo['role'];
    _area = userInfo['area'];
    _cnic = userInfo['cnic'];
    profilePicture = userInfo['profilePicture'] ?? "";

    cnicPicture = userInfo['cnicPicture'] ?? "";
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  File? cnicImage;
  File? profileImage;
  final picker = ImagePicker();

  // Logout functionality
  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profilePicture', "");
    // await prefs.setString('token', "");

    await SessionManager.clearSession();

    Provider.of<ProductViewModel>(context, listen: false).clearallList();

    profileImage = null;
    cnicImage = null;
    // Clear session data
    Navigator.pushReplacementNamed(
        context, RoutesName.renterLoginScreen); // Navigate to the login screen
  }

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
      log(cnicImage!.path);
      log("split image path ${cnicImage!.path.split('/cache/')[1]}");

      notifyListeners();
    }
  }

  Future<void> uploadImages({
    required File? profileImage,
    required File? cnicImage,
    required BuildContext context,
  }) async {
    _setLoading(true);
    final response = await ApiClient.multipartUpload(
      endpoint: role == 'owner'
          ?
          //Owner Auth work fine
          '/renter/upload'
          : '/user/upload',

//User upload
// '/user/upload'

      fields: {}, // Add any form fields if needed
      files: {
        'personalPicture': profileImage,
        'cnicPicture': cnicImage,
      },
      isToken: true,
    );

    _setLoading(false);

    if (response['success'] == true) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('profilePicture', profileImage?.path ?? "");
      await prefs.setString('cnicPicture', cnicImage?.path ?? "");

      profileImage = null;
      cnicImage = null;
      HelperFunctions.showSuccessSnackbar(context, 'Upload successful');

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Upload failed')),
      );
    }
  }

  Future<void> editUserProfile({
    required File? profileImage,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String area,
    required BuildContext context,
  }) async {
    final response = await ApiClient.multipartUpload(
      apiType: "PUT",
      endpoint: '/users/profile-renter/update',
      fields: {
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "area": area
      }, // Add any form fields if needed
      files: {
        'personalPicture': profileImage,
        //profilePicture
      },
      isToken: true,
    );

    if (response['success'] == true) {
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('profilePicture', profileImage?.path ?? "");
      await prefs.setString('fullName', fullName);
      await prefs.setString('email', email);

      await HelperFunctions.showSuccessSnackbar(context, 'Upload successful');

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? 'Upload failed')),
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required BuildContext context,
  }) async {
    final response = await ApiClient.put(
        isToken: true,
        role == 'owner'
            ? "/users/change-password"
            : "/users/renter/change-password",
        {"currentPassword": currentPassword, "newPassword": newPassword});

    if (response['success'] == true) {
      HelperFunctions.showSuccessSnackbar(context, response['message']);

      Navigator.pop(context);
    } else {
      HelperFunctions.showErrorSnackbar(
          context, response['message'] ?? 'Password change failed');
    }
  }

  Future<void> deleteAccount(BuildContext context) async {
    // Show loader dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final response = await ApiClient.delete(role == 'owner'
          ? "users/delete-account"
          : "users/renter/delete-account");

      Navigator.pop(context); // Close loader

      if (response.statusCode == 200) {
        HelperFunctions.showSuccessSnackbar(
            context, "Account deleted successfully");

        logout(context);
      } else {
        final errorData = jsonDecode(response.body);

        // final resData = jsonDecode(response.body);
        HelperFunctions.showErrorSnackbar(
            context, errorData['message'] ?? "Failed to delete account");
      }
    } catch (e) {
      Navigator.pop(context); // Close loader
      HelperFunctions.showErrorSnackbar(context, "An error occurred: $e");
    }
  }

  Future<void> getProfile({
    required BuildContext context,
  }) async {
    final response = await ApiClient.get(
        role == 'owner' ? "/users/profile" : "/users/profile-renter",
        isToken: true);

    if (response['success'] == true) {
      log(response.toString());
      log(response['message']['user']['profilePicture']);
      log(response['message']['user']['fullName']);
      log(response['message']['user']['role']);

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(
          'profilePicture', response['message']['user']['profilePicture']);
      await prefs.setString(
          'cnicPicture', response['message']['user']['cnicPicture']);
      await prefs.setString('fullName', fullName ?? "");
      await prefs.setString('role', role ?? "");

      // await HelperFunctions.showSuccessSnackbar(context, 'Upload successful');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(response['message'] ??
                'Didnt get detail , SOmething went wrong ')),
      );
    }
  }
}
