import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';

class ReviewViewmodel extends ChangeNotifier {
  int _rating = 0;
  String _comment = "";
  bool _isLoading = false;

  double averageRating = 0.0;
  List<dynamic> reviews = [];

  int get rating => _rating;
  String get comment => _comment;
  bool get isLoading => _isLoading;

  void updateRating(int value) {
    _rating = value;
    notifyListeners();
  }

  void updateComment(String value) {
    _comment = value;
    notifyListeners();
  }

  Future<void> submitReview(BuildContext context, String agreementId) async {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a rating")),
      );
      return;
    }
    if (_comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please write a comment")),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    final response = await ApiClient.post(
      "/reviews",
      {
        "agreementId": agreementId,
        "rating": _rating,
        "comment": _comment,
      },
      isToken: true,
    );

    _isLoading = false;
    notifyListeners();

    if (response["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(response["message"] ?? "Review added successfully")),
      );

      Navigator.pop(
          context, true); // return true so previous screen can refresh
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response["message"] ?? "Something went wrong")),
      );
    }
  }

  Future<void> fetchReviews(String ownerId) async {
    _isLoading = true;
    notifyListeners();

    final response = await ApiClient.get("/reviews/owner/$ownerId");

    if (response['success'] == true) {
      reviews = response['message']; // API returns a list
      _calculateAverageRating();
    } else {
      reviews = [];
      averageRating = 0.0;
    }

    _isLoading = false;
    notifyListeners();
  }

  void _calculateAverageRating() {
    if (reviews.isEmpty) {
      averageRating = 0.0;
      return;
    }

    double total = 0;
    for (var review in reviews) {
      total += (review['rating'] ?? 0).toDouble();
    }
    averageRating = total / reviews.length;
  }

  void resetRating() {
    _rating = 0;
    _comment = "";

    averageRating = 0.0;
    reviews = [];

    notifyListeners();
  }
}
