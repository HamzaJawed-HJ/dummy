import 'dart:convert';
import 'dart:io';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  ApiClient apiClient = ApiClient();

  static Future<Map<String, dynamic>> createProduct({
    required String token,
    required String category,
    required String name,
    required String description,
    required String price,
    required String timePeriod,
    required String location,
    required File imageFile,
  }) async {
    try {
      var uri = Uri.parse('${ApiClient.baseUrl}/products/create');

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['category'] = category
        ..fields['name'] = name
        ..fields['description'] = description
        ..fields['price'] = price
        ..fields['timePeriod'] = timePeriod
        ..fields['location'] = location
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      var response = await request.send();

      final responseBody = await http.Response.fromStream(response);

      final decoded = jsonDecode(responseBody.body);
      print(' Product Create Response: ${responseBody.body}');

      if (response.statusCode == 201) {
        return {"success": true, 'message': decoded['message']};
      } else {
        return {"success": true, 'message': decoded['message'] ?? 'Failed to create product'};
      }
    } catch (e) {
      print(' Product Create Error: $e');
      return {'message': 'An error occurred'};
    }
  }

  static Future<Map<String, dynamic>> editProduct({
    required String token,
    required String category,
    required String name,
    required String description,
    required String price,
    required String timePeriod,
    required String location,
    required String imageFile,
    required String productId,
  }) async {
    try {
      var uri = Uri.parse('${ApiClient.baseUrl}/products/$productId');

      var request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer $token'
        ..fields['category'] = category
        ..fields['name'] = name
        ..fields['description'] = description
        ..fields['price'] = price
        ..fields['timePeriod'] = timePeriod
        ..fields['location'] = location;

// Only add image file if it's not a URL
      if (!imageFile.split(":")[0].startsWith("http")) {
        request.files.add(await http.MultipartFile.fromPath('image', imageFile));
      }

      var response = await request.send();

      final responseBody = await http.Response.fromStream(response);

      final decoded = jsonDecode(responseBody.body);
      print(' Product Create Response: ${responseBody.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        return {"success": true, 'message': decoded['message'], 'product': decoded['product']};
      } else {
        return {"success": true, 'message': decoded['message'] ?? 'Failed to create product'};
      }
    } catch (e) {
      print(' Product Create Error: $e');
      return {'message': 'An error occurred'};
    }
  }

  static Future<List<dynamic>> fetchMyProducts() async {
    final token = await SessionManager.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiClient.baseUrl}/products/my'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      return products;
    } else {
      throw Exception('Failed to fetch your products');
    }
  }

  static Future<List<dynamic>> fetchAllProducts() async {
    final token = await SessionManager.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiClient.baseUrl}/products'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      return products;
    } else {
      throw Exception('Failed to fetch your products');
    }
  }

  static Future<List<dynamic>> fetchAllRequest() async {
    final token = await SessionManager.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiClient.baseUrl}/rentalRequests'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      return products;
    } else {
      throw Exception('Failed to fetch your products');
    }
  }

  static Future<List<dynamic>> fetchAllNotifications() async {
    final token = await SessionManager.getAccessToken();

    final response = await http.get(
      Uri.parse('${ApiClient.baseUrl}/notifications'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> products = json.decode(response.body);
      return products;
    } else {
      throw Exception('Failed to fetch your products');
    }
  }

  static Future<Map<String, dynamic>> updateRentalRequestStatus({
    required String requestId,
    required String status,
  }) async {
    final token = await SessionManager.getAccessToken();
    final url = Uri.parse('${ApiClient.baseUrl}/rentalRequests/$requestId/status');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'status': status}),
    );

    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'success': true, 'data': data};
    } else {
      return {'success': false, 'message': data['message']};
    }
  }
}
