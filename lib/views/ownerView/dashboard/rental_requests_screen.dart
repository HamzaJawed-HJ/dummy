import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/chat_viewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/user_chat_screen.dart';
import 'package:provider/provider.dart';

class RentalRequestsScreen extends StatefulWidget {
  @override
  State<RentalRequestsScreen> createState() => _RentalRequestsScreenState();
}

class _RentalRequestsScreenState extends State<RentalRequestsScreen> {
  @override
  void initState() {
    Provider.of<ProductViewModel>(context, listen: false).getAllNotification();

    loadData();
    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    await Provider.of<UserProfileViewModel>(context, listen: false)
        .loadUserData();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatVM = Provider.of<ChatViewModel>(context, listen: false);
    final imageVM = Provider.of<UserProfileViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'Rental Requests',
          style: const TextStyle(
            fontSize: 26,
            wordSpacing: 2,
            fontWeight: FontWeight.bold,
            // color: blueColor,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductViewModel>(builder: (context, value, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusBox(value.approvalList.length.toString(),
                      "Total Requests", Colors.blue),
                  _buildStatusBox(value.rentalPendingCount.toString(),
                      "Pending", Colors.orange),
                  _buildStatusBox(value.rentalAccpetedCount.toString(),
                      "Accepted", Colors.green),
                ],
              );
            }),
            SizedBox(height: 30),
            Text("Rental Requests",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(
              child:
                  Consumer<ProductViewModel>(builder: (context, productVM, _) {
                if (productVM.error != null) {
                  return Center(
                      child:
                          Text('Error: ${productVM.error}\n Check Internet'));
                }

                if (productVM.request.isEmpty) {
                  Center(child: Text('No Rental Request'));
                }

                return RefreshIndicator(
                  onRefresh: productVM.getAllNotification,
                  child: ListView.builder(
                    itemCount: productVM.approvalList.length,
                    itemBuilder: (context, index) {
                      var req = productVM.approvalList[index];
                      print(req.renterRequestID!.sId);
                      return Card(
                        elevation: 3,
                        margin: EdgeInsets.only(bottom: 20),
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 60,
                                    width: 80,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black45, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            "${ApiClient.baseImageUrl}${req.renterRequestID!.productID!.image!}",
                                          ),
                                          fit: BoxFit.cover),
                                      //radius: 24,
                                    ),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            //name
                                            Text(
                                                req.renterRequestID!.productID!
                                                    .name!
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: getStatusColor(req
                                                    .renterRequestID!.status!),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                  req.renterRequestID!.status ??
                                                      "",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        //price
                                        Text(
                                            req.renterRequestID!.productID!
                                                .price!
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.blue[700],
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text("Renter Information",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                      "${req.renterRequestID!.renterID!.fullName!}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                      "${req.renterRequestID!.renterID!.area!}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.email, size: 20),
                                  SizedBox(width: 6),
                                  Text(
                                      req.renterRequestID!.renterID!.email ??
                                          "",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (req.renterRequestID!.status! == 'accepted')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, bottom: 10),
                                  child: Center(
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => ChatScreen(
                                            //           // conversationId: id,
                                            //           conversationId: chatVM
                                            //               .conversationModel!.id
                                            //           // conversationId,
                                            //           ,
                                            //           fullName: chatVM
                                            //               .conversationModel!
                                            //               .participant
                                            //               .fullName,
                                            //           imageUrl: chatVM
                                            //               .conversationModel
                                            //               !
                                            //               .participant
                                            //               .profilePicture),
                                            //     ));
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 40),
                                            backgroundColor: Colors.blue[400],
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons
                                                    .check_circle_outline_rounded,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text("Accepted",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 2,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              print(req.renterRequestID!
                                                  .renterID!.sId!);
                                              chatVM.chartStart(
                                                  otherUserId: req
                                                      .renterRequestID!
                                                      .renterID!
                                                      .sId!,
                                                  context: context,

image: "${ApiClient.baseImageUrl}+${imageVM.profilePicture}",

                                                  // image: req
                                                  //         .renterRequestID
                                                  //         ?.renterID
                                                  //         ?.fullName ??
                                                  //     "",
                                                  name: req
                                                          .renterRequestID
                                                          ?.renterID
                                                          ?.fullName ??
                                                      "");

                                              // print(req.owner!.id);
                                              // chatVM.chartStart(
                                              //     context: context,
                                              //     otherUserId: req.owner!.id!,
                                              //     image:
                                              //         req.owner?.fullName ?? "",
                                              //     name: req.owner?.fullName ??
                                              //         "");
                                            },
                                            style: ElevatedButton.styleFrom(
                                              minimumSize:
                                                  Size(double.infinity, 40),
                                              backgroundColor:
                                                  Colors.green[400],
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .chat_bubble_outline_rounded,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Lets Start Conversation",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        letterSpacing: 2,
                                                        color: Colors.white)),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                )
                              else if (req.renterRequestID!.status! ==
                                  'pending')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Provider.of<ProductViewModel>(
                                                    context,
                                                    listen: false)
                                                .updateRentalRequestStatus(
                                                    req.renterRequestID!.sId!,
                                                    "accepted",
                                                    context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          child: Text("Accept",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Provider.of<ProductViewModel>(
                                                    context,
                                                    listen: false)
                                                .updateRentalRequestStatus(
                                                    req.renterRequestID!.sId!,
                                                    "rejected",
                                                    context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          ),
                                          child: Text("Decline",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBox(String count, String label, Color color) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 90,
          width: 90,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(16)),
          child:
              Text(count, style: TextStyle(color: Colors.white, fontSize: 30)),
        ),
        SizedBox(height: 6),
        Text(label,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
