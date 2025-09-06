import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../viewModel/renter_viewModel/payment_provider.dart';

class PaymentScreen extends StatelessWidget {
  final String agreementId;
  final double amountPKR;
  final String productName;

  const PaymentScreen({
    Key? key,
    required this.agreementId,
    required this.amountPKR,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: $productName', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Amount: ${amountPKR.toStringAsFixed(0)} PKR',
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
            provider.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          textStyle:
                              TextStyle(fontSize: 18, color: Colors.white)),
                      onPressed: () async {
                        bool success = await provider.payForAgreement(
                            agreementId, amountPKR);
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Payment Successful!')),
                          );
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Payment Failed!')),
                          );
                        }
                      },
                      child: Text('Pay Now',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
