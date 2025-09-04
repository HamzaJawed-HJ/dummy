import 'package:flutter/material.dart';

class ReviewViewmodel extends ChangeNotifier {
  int _rating = 0;
  String _comment = "";

  int get rating => _rating;
  String get comment => _comment;

  void updateRating(int value) {
    _rating = value;
    notifyListeners();
  }

  void updateComment(String value) {
    _comment = value;
    notifyListeners();
  }
}