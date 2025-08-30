import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/models/product_model.dart';
import 'package:fyp_renterra_frontend/data/models/rental_approval_model.dart';
import 'package:fyp_renterra_frontend/data/models/request_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/data/repositories/product_repository.dart';

class ProductViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<void> createProduct({
    required String category,
    required String name,
    required String description,
    required String price,
    required String timePeriod,
    required File imageFile,
    required BuildContext context,
  }) async {
    _setLoading(true);

    final token =
        await SessionManager.getAccessToken(); // or any secure storage method

    Map<String, String?> userInfo = await SessionManager.getUserInfo();

    final location = userInfo['area'];

    final response = await ProductRepository.createProduct(
      token: token!,
      category: category,
      name: name,
      description: description,
      price: price,
      timePeriod: timePeriod,
      location: location!,
      imageFile: imageFile,
    );

    _setLoading(false);

    if (response['success']) {
      notifyListeners();

      HelperFunctions.showSuccessSnackbar(context, response['message']);
    } else {
      notifyListeners();
      HelperFunctions.showErrorSnackbar(context, response['message']);
    }
  }

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  String? error;

  List<ProductModel> _allProducts = []; // for search


  Future<void> getMyProducts() async {
    try {
      error = null;
      final data = await ProductRepository.fetchMyProducts();
      _products =
          data.map((e) => ProductModel.fromJson(e)).toList().reversed.toList();
    } catch (e) {
      _products = [];
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  ProductModel getById(String id) {
    return _products.firstWhere((prod) => prod.id == id);
  }

//-------------


Future<void> getAllProducts() async {
  try {
    error = null;
    final data = await ProductRepository.fetchAllProducts();
    _allProducts = data.map((e) => ProductModel.fromJson(e)).toList().reversed.toList();
    _products = List.from(_allProducts); // start with all products
  } catch (e) {
    _products = [];
    _allProducts = [];
    error = e.toString();
  } finally {
    notifyListeners();
  }
}


void searchProducts(String query) {
  if (query.isEmpty) {
    _products = List.from(_allProducts);
  } else {
    _products = _allProducts.where((p) {
      return p.name.toLowerCase().contains(query.toLowerCase()) ||
             p.category.toLowerCase().contains(query.toLowerCase()) ||
             p.location.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
  notifyListeners();
}



  // Future<void> getAllProducts() async {
  //   try {
  //     error = null;
  //     final data = await ProductRepository.fetchAllProducts();
  //     _products =
  //         data.map((e) => ProductModel.fromJson(e)).toList().reversed.toList();
  //   } catch (e) {
  //     _products = [];
  //     error = e.toString();
  //   } finally {
  //     notifyListeners();
  //   }
  // }

  List<RequestModel> _request = [];
  List<RequestModel> get request => _request;

  int get pendingCount => request.where((r) => r.status == 'pending').length;
  int get acceptedCount => request.where((r) => r.status == 'accepted').length;

  Future<void> renteRequest({
    required BuildContext context,
    required String productId,
  }) async {
    _setLoading(true);
    log(productId.toString());
    try {
      // Call the API method from AuthRepository
      final response = await ApiClient.post(
          "/rentalRequests/create", {'productId': productId},
          isToken: true);

      _setLoading(false);

      if (response.containsKey('message') &&
          response['message'].toString().toLowerCase().contains('success')) {
        notifyListeners();

        HelperFunctions.showSuccessSnackbar(
            context, response['message'].toString());
        // Navigate to dashboard
        Navigator.pop(context);
      } else {
        HelperFunctions.showErrorSnackbar(context, response['message']);
        notifyListeners();
      }
    } catch (error) {
      HelperFunctions.showErrorSnackbar(context, error.toString());
      _setLoading(false);
      notifyListeners();
    }
  }

  Future<void> getAllRequest() async {
    try {
      error = null;
      final data = await ProductRepository.fetchAllRequest();
      _request =
          data.map((e) => RequestModel.fromJson(e)).toList().reversed.toList();
    } catch (e) {
      _request = [];
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  List<RentalApprovalModel> _approvalList = [];

  List<RentalApprovalModel> get approvalList => _approvalList;

  int get rentalPendingCount => approvalList
      .where(
        (element) => element.renterRequestID?.status == 'pending',
      )
      .length;
  int get rentalAccpetedCount => approvalList
      .where(
        (element) => element.renterRequestID?.status == 'accepted',
      )
      .length;

  Future<void> getAllNotification() async {
    try {
      error = null;
      final data = await ProductRepository.fetchAllNotifications();
      _approvalList = data.map((e) => RentalApprovalModel.fromJson(e)).toList();
    } catch (e) {
      _approvalList = [];
      error = e.toString();
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateRentalRequestStatus(
      String requestId, String status, BuildContext context) async {
    _setLoading(true);
    final result = await ProductRepository.updateRentalRequestStatus(
      requestId: requestId,
      status: status,
    );
    _setLoading(false);

    if (result['success']) {
      HelperFunctions.showSuccessSnackbar(context, 'Status updated');
      await getAllNotification(); // 🔁 Auto refresh
    } else {
      HelperFunctions.showErrorSnackbar(context, result['message']);
    }
  }

  Future<void> deleteProduct(String productId, BuildContext context) async {
    print(productId);
    final response = await ApiClient.delete('products/$productId');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product deleted successfully')),
      );
      await getAllProducts();
      notifyListeners();
    } else {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> deleteRentalRequest(String id, BuildContext context) async {
    try {
      final response = await ApiClient.delete('rentalRequests/$id');
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rental request canceled successfully')),
        );
        await getAllRequest(); // Refresh list
      } else {
        throw Exception('Failed to delete rental request');
      }
    } catch (e) {
      print("Delete error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting rental request')),
      );
    }
  }

  Future<void> editProduct({
    required String category,
    required String name,
    required String description,
    required String price,
    required String timePeriod,
    required String imageFile,
    required String productId,
    required BuildContext context,
  }) async {
    _setLoading(true);

    final token =
        await SessionManager.getAccessToken(); // or any secure storage method

    Map<String, String?> userInfo = await SessionManager.getUserInfo();

    final location = userInfo['area'];

    final response = await ProductRepository.editProduct(
      productId: productId,
      token: token!,
      category: category,
      name: name,
      description: description,
      price: price,
      timePeriod: timePeriod,
      location: location!,
      imageFile: imageFile,
    );
    _setLoading(false);

    if (response['success']) {
      ProductModel data = ProductModel.fromJson((response['product']));
      log(data.id + "idddddddddddd");
      notifyListeners();
      for (int i = 0; _products.length > i; i++) {
        if (_products[i].id == data.id) {
          _products[i] = data;
        }
      }
//  _products = data.map((e) => ProductModel.fromJson(e)).toList().reversed.toList();
      HelperFunctions.showSuccessSnackbar(context, response['message']);
      Navigator.pop(context);
      // MaterialPageRoute(builder: (context) => ,)
      // ,
      //   (route) => false,

      // );
    } else {
      notifyListeners();
      HelperFunctions.showErrorSnackbar(context, response['message']);
    }
  }
}
