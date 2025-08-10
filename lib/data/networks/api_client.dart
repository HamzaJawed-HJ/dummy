import 'dart:developer';
import 'dart:io';

import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:path/path.dart';

class ApiClient {
  // static final String ipUrl = '192.168.0.34';
  // 192.168.186.226
  static final String ipUrl = '192.168.0.35';
  static final String baseUrl = "http://$ipUrl:3000/api";

  static final String baseImageUrl = "http://$ipUrl:3000/uploads/";
  static final String baseImageUrlupload = "http://$ipUrl:3000/uploads";

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

  static Future<http.Response> delete(String endpoint) async {
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
        final res = jsonDecode(response.body);
        return {'success': true, 'message': res['message'], 'data': res};
        // return {'success': true, 'data': jsonDecode(response.body)};
        // return jsonDecode(response.body);
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

  // In your ApiClient class
  static Future<Map<String, dynamic>> multipartUpload({
    required String endpoint,
    required Map<String, String> fields,
    required Map<String, File?> files,
    String? apiType = "POST",

    // key: fieldName, value: File
    bool isToken = false,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final request = http.MultipartRequest(apiType!, uri);

      // Add token to header
      if (isToken) {
        final token = await SessionManager.getAccessToken();
        if (token != null && token.isNotEmpty) {
          request.headers['Authorization'] = 'Bearer $token';
        }
      }

      // Add fields (text fields if needed)
      request.fields.addAll(fields);

      // Add files
      for (var entry in files.entries) {
        final fieldName = entry.key;
        final file = entry.value;

        if (file != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              fieldName,
              file.path,
              filename: basename(file.path),
            ),
          );
        }
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      log(responseBody.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Upload successful',
          'data': jsonDecode(responseBody),
        };
      } else {
        return {
          'success': false,
          'message': 'Failed with status ${response.statusCode}',
          'data': jsonDecode(responseBody),
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}
