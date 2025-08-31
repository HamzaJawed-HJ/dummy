import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/agrement_pdf_screen.dart';
import 'package:provider/provider.dart';

class AllAgreementScreen extends StatefulWidget {
  const AllAgreementScreen({super.key});

  @override
  State<AllAgreementScreen> createState() => _AllAgreementScreenState();
}

class _AllAgreementScreenState extends State<AllAgreementScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AgreementDetailViewModel>(context, listen: false)
          .fetchAgreements();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Agreements")),
      body: Consumer<AgreementDetailViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.errorMessage != null) {
            return Center(child: Text(vm.errorMessage!));
          }

          if (vm.agreements.isEmpty) {
            return const Center(child: Text("No agreements found"));
          }

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: vm.agreements.length,
              itemBuilder: (context, index) {
                final agreement = vm.agreements[index] as Map<String, dynamic>;

                return Card(
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgreementPdfScreen(
                            pdfUrl:
                                ApiClient.basepdfUrl + agreement['fileUrl']),
                      ),
                    ),
                    child: ListTile(
                      title: Text("Product: ${agreement['productID']['name']}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Owner: ${agreement['ownerID']['fullName']}"),
                          Text("Renter: ${agreement['renterID']['fullName']}"),
                          Text("Pickup: ${agreement['pickupDate']}"),
                          Text("Return: ${agreement['returnDate']}"),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
