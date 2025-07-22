import 'package:fyp_renterra_frontend/data/networks/auth_api.dart';

class AuthRepository {
  // Register User
  static Future<Map<String, dynamic>> registerUser({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String area,
    required String cnic,
  }) async {
    final data = {
      'email': email,
      'fullName': fullName,
      'phoneNumber': phone,
      'password': password,
      'cnic': cnic,
      'area': area,
      "role": "renter"
    };
    return await AuthAPI.registerUser(data);
  }

  //User login
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
  }) async {
    final data = {
      'email': email,
      'password': password,
    };
    return await AuthAPI.loginUser(data);
  }

  // Register Renter
  static Future<Map<String, dynamic>> registerRenter({
    required String fullName,
    required String phone,
    required String email,
    required String password,
    required String shopName,
    required String shopAddress,
    required String area,
    required String cnic,
  }) async {
    final data = {
      'email': email,
      'fullName': fullName,
      'password': password,
      'phoneNumber': phone,
      'cnic': cnic,
      'area': area,
      'shopName': shopName,
      'shopAddress': shopAddress,
      "role": "owner"
    };
    return await AuthAPI.registerRenter(data);
  }

//renter login
  static Future<Map<String, dynamic>> loginRenter({
    required String email,
    required String password,
  }) async {
    final data = {
      'email': email,
      'password': password,
    };
    return await AuthAPI.loginRenter(data);
  }
}
