import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiClient {
  // static final String ipUrl = '192.168.0.34';
  // 192.168.186.226
  static final String ipUrl = '192.168.0.37';
  static final String baseUrl = "http://$ipUrl:3000/api";

  static final String baseImageUrl = "http://$ipUrl:3000/uploads/";

  // Common POST requests
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    bool isToken = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print(uri);

      // Base headers
      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      // Add token if required
      if (isToken) {
        final token = await SessionManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http
          .post(
            uri,
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body.toString());
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'message': errorData['message'],
          'data': errorData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred "IP URL ": $e',
      };
    }
  }

  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    final token = await SessionManager.getAccessToken();

    final response = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return response;
  }

  static Future<Map<String, dynamic>> get(
    String endpoint, {
    bool isToken = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print(uri);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (isToken) {
        final token = await SessionManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body.toString());
        return {'success': true, 'message': jsonDecode(response.body)};
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'message': errorData['message'],
          'data': errorData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred "IP URL ": $e',
      };
    }
  }

  static Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data, {
    bool isToken = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      print(uri);

      Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      if (isToken) {
        final token = await SessionManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          headers['Authorization'] = 'Bearer $token';
        }
      }

      final response = await http
          .put(
            uri,
            headers: headers,
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body.toString());
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        return {
          'message': errorData['message'],
          'data': errorData,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'An error occurred "IP URL ": $e',
      };
    }
  }
}
