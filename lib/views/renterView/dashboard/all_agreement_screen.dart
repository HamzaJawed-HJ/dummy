import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/agrement_pdf_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/review_screen.dart';
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
    Color getStatusColor(String status) {
      switch (status) {
        case 'active':
          return Colors.blue;
        case 'completed':
          return Colors.green;
        default:
          return Colors.grey;
      }
    }

    final profileViewModel = Provider.of<UserProfileViewModel>(context);
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
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Product: ${agreement['productID']['name']}"),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: getStatusColor("${agreement['status']}"),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${agreement['status']}",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Owner: ${agreement['ownerID']['fullName']}"),
                          Text("Renter: ${agreement['renterID']['fullName']}"),
                          Text("Pickup: ${agreement['pickupDate']}"),
                          Text("Return: ${agreement['returnDate']}"),
                          Text("Status: ${agreement['status']}"),
                          SizedBox(
                            height: 15,
                          ),
                          //owner role button
                          if (profileViewModel.role == "owner")
                            ElevatedButton(
                              onPressed: () {
                                if (agreement['status'] != 'completed')
                                  vm.agreementStatusChange(agreement['_id']);
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                backgroundColor: agreement['status'] == 'active'
                                    ? Colors.blue[400]
                                    : Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.check_circle_outline_rounded,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  vm.loadingAgreements
                                          .contains(agreement['_id'])
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 10,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          agreement['status'] == 'active'
                                              ? "Mark As Completed"
                                              : "Done",
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 2,
                                              color: Colors.white)),
                                ],
                              ),
                            ),

                          if (profileViewModel.role == "renter")
                            ElevatedButton(
                              onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReviewScreen(
                                            agreementId: agreement['_id'],
                                          )

                                      //    AgreementPdfScreen(
                                      //       pdfUrl: ApiClient.basepdfUrl +
                                      //           agreement['fileUrl']),
                                      ),
                                )
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 40),
                                backgroundColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Write Reviews",
                                      style: TextStyle(
                                          fontSize: 16,
                                          letterSpacing: 2,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
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
