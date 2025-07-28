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
    await prefs.setString('id', userInfo.id);
    await prefs.setString('profilePicture', userInfo.profilePicture);
    await prefs.setString('cnicPicture', userInfo.cnicPicture);

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
      'id': prefs.getString('id'),
      'profilePicture': prefs.getString('profilePicture'),
      'cnicPicture': prefs.getString('cnicPicture'),
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


    await prefs.setString('profilePicture', renterInfo.profilePicture);
    await prefs.setString('fullName', renterInfo.fullName);
    await prefs.setString('email', renterInfo.email);
    await prefs.setString('shopName', renterInfo.shopAddress);
    await prefs.setString('shopAddress', renterInfo.shopAddress);

    await prefs.setString('id', renterInfo.id);

    await prefs.setString('cnicPicture', renterInfo.cnicPicture);
    await prefs.setString('role', renterInfo.role);
    await prefs.setString('cnic', renterInfo.cnic);
    await prefs.setString('area', renterInfo.area);
    await prefs.setString('phoneNumber', renterInfo.phoneNumber);
  }

  // Get User Information
  static Future<Map<String, String?>> getRenterInfo() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString('id'),
      'profilePicture': prefs.getString('profilePicture'),
      'cnicPicture': prefs.getString('cnicPicture'),
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
