import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PaymentProvider extends ChangeNotifier {
  bool isLoading = false;

  void setLoading(bool val) {
    isLoading = val;
    notifyListeners();
  }

  Future<bool> payForAgreement(String agreementId, double amountInPKR) async {
    try {
      setLoading(true);
      // 1️⃣ Create PaymentIntent on backend
      final res = await ApiClient.post(
        "/payments/create-payment-intent",
        {
          "agreementId": agreementId,
        },
        isToken: true,
      );

      if (res['success'] == false || res['clientSecret'] == null) {
        setLoading(false);
        return false;
      }
      final clientSecret = res['clientSecret'];

      // 2️⃣ Confirm Payment using flutter_stripe
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Renterra',
          style: ThemeMode.light,
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      final stripePaymentIntentId =
          clientSecret.split('_secret').first; // extracts "pi_xxx"
      // 3️⃣ Verify payment on backend
      final verifyRes = await ApiClient.get(
        "/payments/verify?payment_intent_id=$stripePaymentIntentId",
        isToken: true,
      );

      setLoading(false);
      // log(verifyRes['message']['status']);

      if (verifyRes['message']['status'] == 'paid') {
      
        return true;
      } else {
        return false;
      }
    } catch (e) {
      setLoading(false);
      print("Payment Error: $e");
      return false;
    }
  }
}
