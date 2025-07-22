import 'package:fyp_renterra_frontend/data/models/renter_model.dart';
import 'package:fyp_renterra_frontend/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // Save Access Token
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  // Get Access Token
  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  // Save Refresh Token
  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', token);
  }

  // Get Refresh Token longer expiry time (days or weeks)
  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  // Save User Information
  static Future<void> saveUserInfo(User userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', userInfo.fullName);
    await prefs.setString('email', userInfo.email);
    await prefs.setString('phoneNumber', userInfo.phoneNumber);
    await prefs.setString('role', userInfo.role);
    await prefs.setString('cnic', userInfo.cnic);
    await prefs.setString('area', userInfo.area);
  }

  // Get User Information
  static Future<Map<String, String?>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString('fullName'),
      'email': prefs.getString('email'),
      'phoneNumber': prefs.getString('phoneNumber'),
      'role': prefs.getString('role'),
      'cnic': prefs.getString('cnic'),
      'area': prefs.getString('area'),
    };
  }

  // Save Renter Information
  static Future<void> saveRenterInfo(RenterModel renterInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullName', renterInfo.fullName);
    await prefs.setString('email', renterInfo.email);
    await prefs.setString('phoneNumber', renterInfo.phoneNumber);
    await prefs.setString('role', renterInfo.role);
    await prefs.setString('cnic', renterInfo.cnic);
    await prefs.setString('area', renterInfo.area);
    await prefs.setString('shopName', renterInfo.shopAddress);
    await prefs.setString('areaAddress', renterInfo.shopAddress);
  }

  // Get User Information
  static Future<Map<String, String?>> getRenterInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'fullName': prefs.getString('fullName'),
      'email': prefs.getString('email'),
      'phoneNumber': prefs.getString('phoneNumber'),
      'role': prefs.getString('role'),
      'cnic': prefs.getString('cnic'),
      'area': prefs.getString('area'),
      'shopName': prefs.getString('shopName'),
      'shopAddress': prefs.getString('shopAddress'),
    };
  }

  // Clear Session Data
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Check if User is Logged In
  static Future<bool> isLoggedIn() async {
    final accessToken = await getAccessToken();
    return accessToken != null && accessToken.isNotEmpty;
  }
}
