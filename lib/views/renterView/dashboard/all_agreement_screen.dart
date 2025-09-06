import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/onwer_my_reviews.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/agrement_pdf_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/owners_review_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/payment_screen.dart';
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
    // context.read<AgreementDetailViewModel>().fetchAgreements();
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

                return Container(
                  margin: const EdgeInsets.all(8),
                  // width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 6,
                        offset: const Offset(2, 2),
                      )
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgreementPdfScreen(
                            pdfUrl:
                                ApiClient.basepdfUrl + agreement['fileUrl']),
                      ),
                    ),
                    child: Column(
                      children: [
                        if (profileViewModel.role == "renter") ...[
                          if (agreement['isPaid'] == true)
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Payment Completed",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            )
                          else
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Payment Pending",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                        ],
                        ListTile(
                          leading: Icon(
                            Icons.picture_as_pdf_rounded,
                            size: 30,
                            color: getStatusColor("${agreement['status']}"),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Agreement: ${index + 1} ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(
                                        "${agreement['status']}"),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${agreement['status']}",
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ],
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Owner:  ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("${agreement['ownerID']['fullName']}"),
                                ],
                              ),
                              Row(
                                children: [
                                  Text("Agreement:  ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  Text("${agreement['productID']['name']}"),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              //owner role button
                              if (profileViewModel.role == "owner" &&
                                  agreement['status'] == 'active')
                                ElevatedButton(
                                  onPressed: () {
                                    // if (agreement['status'] != 'completed')
                                    vm.agreementStatusChange(agreement['_id']);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    backgroundColor: Colors.blue[400],
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
                                        width: 5,
                                      ),
                                      vm.loadingAgreements
                                              .contains(agreement['_id'])
                                          ? const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            )
                                          : Text("Mark As Complete",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 2,
                                                  color: Colors.white)),
                                    ],
                                  ),
                                ),
                              // renter flow → make payment
                              if (profileViewModel.role == "renter" &&
                                  agreement['status'] == 'active' &&
                                  agreement['isPaid'] == false)
                                ElevatedButton(
                                  onPressed: () {
                                    log(
                                      agreement['productID']['price']
                                          .toString(),
                                    );
                                    log(agreement['_id']);
                                    log(agreement['productID']['name']);
                                    log(agreement['isPaid'].toString());

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentScreen(
                                          agreementId: agreement['_id'],
                                          amountPKR: agreement['productID']
                                                  ['price']
                                              .toDouble(),
                                          productName: agreement['productID']
                                              ['name'],
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 35),
                                    backgroundColor: Colors.blue[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.payment,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("Make Payment",
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 2,
                                              color: Colors.white)),
                                    ],
                                  ),
                                ),
                              // renter flow → already reviewed
                              if (profileViewModel.role == "renter" &&
                                  agreement['status'] == 'completed' &&
                                  agreement['reviewed'] == true)
                                ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             OwnersReviewScreen(
                                    //                 ownerId: agreement['ownerID']
                                    //                     ['_id'],
                                    //                 ownerImageUrl:
                                    //                     ApiClient.baseImageUrl +
                                    //                         profileViewModel
                                    //                             .profilePicture
                                    //                 ,
                                    //                 ownerName: profileViewModel
                                    //                         .fullName ??
                                    //                     "")));
                                  }, // disables button
                                  style: ElevatedButton.styleFrom(
                                    // disabledBackgroundColor: Colors.red[500],
                                    minimumSize: Size(double.infinity, 35),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 54, 114, 244),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.check_circle,
                                          color: Colors.white),
                                      SizedBox(width: 10),
                                      Text("Reviewed",
                                          style: TextStyle(
                                              fontSize: 16,
                                              letterSpacing: 2,
                                              color: Colors.white)),
                                    ],
                                  ),
                                )
                              // renter flow → review
                              ,
                              if (profileViewModel.role == "renter" &&
                                  agreement['status'] == 'completed' &&
                                  agreement['reviewed'] == false)
                                ElevatedButton(
                                  onPressed: () async {
                                    final result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReviewScreen(
                                          agreementId: agreement['_id'],
                                          ownerImageUrl:
                                              ApiClient.baseImageUrl +
                                                  agreement['ownerID']
                                                      ['profilePicture'],
                                          ownerName: agreement['ownerID']
                                              ['fullName'],
                                        ),
                                      ),
                                    );

                                    if (result == true) {
                                      Provider.of<AgreementDetailViewModel>(
                                              context,
                                              listen: false)
                                          .fetchAgreements(); // reload list
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: Size(double.infinity, 40),
                                    backgroundColor: Colors.yellow[700],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.rate_review,
                                          color: Colors.white),
                                      SizedBox(width: 10),
                                      Text("Write Review",
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
                      ],
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
