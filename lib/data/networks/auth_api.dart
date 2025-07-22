import 'api_client.dart';

class AuthAPI {
  static const String registerUserUrl = "/user/register";
  static const String registerRenterUrl = "/renter/register";

  static const String loginUserUrl = "/user/login";
  static const String loginRenterUrl = "/renter/login";

  // Register User API
  static Future<Map<String, dynamic>> registerUser(
      Map<String, dynamic> data) async {
    return await ApiClient.post(registerUserUrl, data);
  }

  // Login User API
  static Future<Map<String, dynamic>> loginUser(
      Map<String, dynamic> data) async {
    return await ApiClient.post(loginUserUrl, data);
  }

  // Register Renter API
  static Future<Map<String, dynamic>> registerRenter(
      Map<String, dynamic> data) async {
    return await ApiClient.post(registerRenterUrl, data);
  }

  // Login Renter API           //Incomplete
  static Future<Map<String, dynamic>> loginRenter(
      Map<String, dynamic> data) async {
    return await ApiClient.post(loginRenterUrl, data);
  }
}
