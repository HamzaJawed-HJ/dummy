import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:provider/provider.dart';

class RentalRequestsScreen extends StatefulWidget {
  @override
  State<RentalRequestsScreen> createState() => _RentalRequestsScreenState();
}

class _RentalRequestsScreenState extends State<RentalRequestsScreen> {
  @override
  void initState() {
    Provider.of<ProductViewModel>(context, listen: false).getAllNotification();
    // TODO: implement initState
    super.initState();
  }

  final List<Map<String, String>> sampleRequests = [
    {
      'product': 'Toyota Corolla',
      'price': 'Rs 1500/day',
      'name': 'Ali Raza',
      'location': 'Karachi',
      'email': 'ali@example.com',
      'status': 'Accepted',
      'image': 'Pending'
    },
    {
      'product': 'Honda Civic',
      'price': 'Rs 1800/day',
      'name': 'Usman Tariq',
      'location': 'Lahore',
      'email': 'usman@example.com',
      'status': 'Pending',
      'image': 'Pending'
    },
  ];

  Color getStatusColor(String status) {
    switch (status) {
      case 'accepted':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'Rental Requests hasvkc',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
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

                // if (productVM.request.isEmpty) {
                //   return const Center(child: Text('No Rental Request'));
                // }

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
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 40),
                                        backgroundColor: Colors.blue[400],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline_rounded,
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
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
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
