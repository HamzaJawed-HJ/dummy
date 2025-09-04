import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:intl/intl.dart';

class AgreementDetailViewModel extends ChangeNotifier {
  bool isLoading = false;
  Map<String, dynamic>? agreementData;
  String? errorMessage;
  DateTime? pickupDate;
  DateTime? returnDate;
  List<dynamic> agreements = [];

  Set<String> loadingAgreements = {};

  bool isStatusLoading = false;

  /// Fetch agreement detail from API
  Future<void> fetchDetail(String rentalRequestId) async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response =
          await ApiClient.get("/agreements/$rentalRequestId", isToken: true);

      if (response['success'] == true) {
        agreementData = response['message'];
      } else {
        errorMessage = response['message'] ?? "Something went wrong";
      }
    } catch (e) {
      errorMessage = "Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void setPickupDate(DateTime? date) {
    pickupDate = date;
    notifyListeners();
  }

  void setReturnDate(DateTime? date) {
    returnDate = date;
    notifyListeners();
  }

  void resetDates() {
    pickupDate = null;
    returnDate = null;
    notifyListeners();
  }

  Future<void> proceedAgreement(
      String rentalRequestId, BuildContext context) async {
    if (pickupDate == null || returnDate == null) {
      errorMessage = "Please select both pickup and return dates";
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      notifyListeners();

      final body = {
        "rentalRequestId": rentalRequestId,
        "pickupDate":
            pickupDate!.toIso8601String().split("T")[0], // format yyyy-MM-dd
        "returnDate": returnDate!.toIso8601String().split("T")[0],
      };

      final response =
          await ApiClient.post("/agreements/generate", body, isToken: true);

      if (response['success'] == true) {
        isLoading = false;
        notifyListeners();

        // ✅ Success snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Agreement generated successfully")),
        );

        // ✅ Show popup dialog
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Success"),
            content: const Text(
                "Your rental agreement has been generated successfully."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        );
        Navigator.pop(context);
      } else {
        isLoading = false;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(response['message'] ?? "Failed to generate agreement")),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  Future<void> fetchAgreements() async {
    try {
      isLoading = true;
      errorMessage = null;
      notifyListeners();

      final response = await ApiClient.get("/agreements/", isToken: true);

      if (response['success'] == true) {
        log("Fetch Agreements Response: ${response.toString()}");
        // access agreements inside message
        final data = response['message'];
        agreements = data['agreements'] as List<dynamic>;

        print("Agreements length: ${agreements.length}");
        print(agreements);
      } else {
        errorMessage = "Failed to load agreements: ${response['message']}";
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> agreementStatusChange(String agreementId) async {
    try {
      loadingAgreements.add(agreementId);
      notifyListeners();

      final response = await ApiClient.put(
        "/agreements/$agreementId/complete",
        {},
        isToken: true,
      );

      if (response['success'] == true) {
        final index = agreements.indexWhere((a) => a['_id'] == agreementId);
        if (index != -1) {
          agreements[index]['status'] = 'completed';
        }
      } else {
        errorMessage = response['message'] ?? "Failed to update status";
      }
    } catch (e) {
      errorMessage = "Error: $e";
    } finally {
      loadingAgreements.remove(agreementId);
      notifyListeners();
    }
  }
}

String formatDate(String date) {
  try {
    return DateFormat("dd MMM yyyy").format(DateTime.parse(date));
  } catch (e) {
    return date;
  }
}
