import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/models/renter_model.dart';
import 'package:fyp_renterra_frontend/data/repositories/auth_repository.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';

class RenterAuthViewModel extends ChangeNotifier {
  bool isLoading = false;

  String? _errorMessage;
  RenterModel? renterDetail;

  String? get errorMessage => _errorMessage;
  //RenterModel? get renterDetail => _renterDetail;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // Register Renter
  Future<void> registerRenter({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String shopName,
    required String shopAddress,
    required String area,
    required String cnic,
    required BuildContext context,
  }) async {
    _setLoading(true);

    final response = await AuthRepository.registerRenter(
      fullName: fullName,
      phone: phone,
      email: email,
      password: password,
      shopName: shopName,
      shopAddress: shopAddress,
      area: area,
      cnic: cnic,
    );

    _setLoading(false);

    if (response.containsKey('message') &&
        response['message'].toString().toLowerCase().contains('success')) {
      HelperFunctions.showSuccessSnackbar(
          context, 'Renter registered successfully');
      Navigator.pushReplacementNamed(context, RoutesName.renterLoginScreen);
    } else {
      HelperFunctions.showErrorSnackbar(context, response['message']);
    }
  }

  // Login User
  Future<void> loginRenter({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);

    try {
      // Call the API method from AuthRepository
      final response = await AuthRepository.loginRenter(
        email: email,
        password: password,
      );

      _setLoading(false);

      if (response['token'] != null &&
          response['user'] != null &&
          response['user']['role'] == 'owner') {
        // Create a User object from the response
        renterDetail = RenterModel.fromJson(response);
        print("Token: ${renterDetail!.accessToken.toString()}");
        notifyListeners();

        // Save user data and tokens to session
        await SessionManager.saveAccessToken(
            renterDetail!.accessToken.toString());
        await SessionManager.saveRenterInfo(renterDetail!);

        // // Verify stored data (optional debugging)
        // String? accessToken = await SessionManager.getAccessToken();
        // Map<String, String?> userInfo = await SessionManager.getUserInfo();

        // print('Access Token: $accessToken');
        // print('Refresh Token: $refreshToken');
        // print('User Info: $userInfo');

        HelperFunctions.showSuccessSnackbar(context, 'LogIn successfully');

        // Navigate to dashboard
        Navigator.pushReplacementNamed(
            context, RoutesName.renterDashboardScreen);
      } else {
        print("test " + response['message']);

        HelperFunctions.showErrorSnackbar(context, response['message']);
        notifyListeners();
      }
    } catch (error) {
      HelperFunctions.showErrorSnackbar(context, error.toString());
      _errorMessage = "Login failed. Please try again.";
      _setLoading(false);
      notifyListeners();
    }
  }
}
