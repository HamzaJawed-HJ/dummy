import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:convert'; // Import dart:convert for jsonDecode

class HelperFunctions {
  static showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  // static void showErrorSnackbar(BuildContext context, String errorResponse) {
  //   // Default error message
  //   String message = "Something went wrong";

  //   try {
  //     // If the errorResponse is a valid JSON string
  //     final Map<String, dynamic> errorMap = jsonDecode(errorResponse);

  //     // Extract status code from the response
  //     int statusCode = errorMap['statusCode'] ?? 500;

  //     // Mapping status codes to user-friendly messages
  //     switch (statusCode) {
  //       case 200:
  //         message = "Request successful!";
  //         break;
  //       case 400:
  //         message = "Invalid request. Please check your inputs.";
  //         break;
  //       case 401:
  //         message = "You are not authorized to perform this action.";
  //         break;
  //       case 403:
  //         message = "You do not have permission to access this resource.";
  //         break;
  //       case 404:
  //         message =
  //             errorMap['message'] ?? "The requested resource was not found.";
  //         break;
  //       case 405:
  //         message = "This method is not allowed for this request.";
  //         break;
  //       case 500:
  //         message = "Something went wrong. Please try again later.";
  //         break;
  //       case 502:
  //         message = "Server error. Please try again later.";
  //         break;
  //       case 503:
  //         message =
  //             "The service is currently unavailable. Please try again later.";
  //         break;
  //       case 504:
  //         message = "Request timed out. Please try again later.";
  //         break;
  //       default:
  //         message = errorMap['message'] ?? "An unexpected error occurred.";
  //         break;
  //     }
  //   } catch (e) {
  //     // If errorResponse is not a valid JSON, fallback to default message
  //     message = errorResponse ?? "Something went wrong";
  //   }

  //   // Show the message in a snackbar
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //       backgroundColor: Colors.red,
  //     ),
  //   );
  // }

  static showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static Future<XFile?> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.gallery);
  }

  static Future<XFile?> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    return await picker.pickImage(source: ImageSource.camera);
  }
}
