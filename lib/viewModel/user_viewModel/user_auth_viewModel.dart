import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/models/user_model.dart';
import 'package:fyp_renterra_frontend/data/repositories/auth_repository.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';

class UserAuthViewModel extends ChangeNotifier {

  String? _errorMessage;
  User? _user;

  String? get errorMessage => _errorMessage;
  User? get user => _user;

  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Register User
  Future<void> registerUser({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String area,
    required String cnic,
    required BuildContext context,
  }) async {
    _setLoading(true);

    final response = await AuthRepository.registerUser(
      fullName: fullName,
      phone: phone,
      email: email,
      password: password,
      area: area,
      cnic: cnic,
    );

    _setLoading(false);

    if (response.containsKey('message') &&
        response['message'].toString().toLowerCase().contains('success')) {
      HelperFunctions.showSuccessSnackbar(
          context, 'User registered successfully');
      Navigator.pushReplacementNamed(context, RoutesName.userLoginScreen);
    } else {
      HelperFunctions.showErrorSnackbar(context, response['message']);
    }
  }

  // Login User
  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Call the API method from AuthRepository
      final response = await AuthRepository.loginUser(
        email: email,
        password: password,
      );

      _setLoading(false);

      if (response['token'] != null &&
          response['user'] != null &&
          response['user']['role'] == 'renter') {
        // Create a User object from the response
        _user = User.fromJson(response);
        notifyListeners();

        await SessionManager.saveAccessToken(_user!.accessToken.toString());
        // await SessionManager.saveRefreshToken(_user!.refreshToken.toString());
        await SessionManager.saveUserInfo(_user!);

        // String? accessToken = await SessionManager.getAccessToken();
        // String? refreshToken = await SessionManager.getRefreshToken();
        Map<String, String?> userInfo = await SessionManager.getUserInfo();

        // print('Access Token: $accessToken');
        // print('Refresh Token: $refreshToken');
        print('User Info: $userInfo');

        HelperFunctions.showSuccessSnackbar(context, 'User login successfully');

        // Navigate to dashboard
        Navigator.pushReplacementNamed(context, RoutesName.UserDashboardScreen);
      } else {
        print("test " + response['message']);

        HelperFunctions.showErrorSnackbar(context, response['message']);
        notifyListeners();
      }
    } catch (error) {
      _errorMessage = "Login failed. Please try again.";
      _setLoading(false);
      notifyListeners();
    }
  }
}
