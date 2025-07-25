import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:provider/provider.dart';

class MyRequestsScreen extends StatefulWidget {
  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
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
  void initState() {
    Provider.of<ProductViewModel>(context, listen: false).getAllRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   final productVM = Provider.of<ProductViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Text(
          'My Requests',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProductViewModel>(builder: (context, count, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatusBox(count.request.length.toString(),
                      "Total Requests", Colors.blue),
                  _buildStatusBox(
                      count.pendingCount.toString(), "Pending", Colors.orange),
                  _buildStatusBox(
                      count.acceptedCount.toString(), "Accepted", Colors.green),
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
                  return const Center(child: Text('No Rental Request'));
                }

                return RefreshIndicator(
                  onRefresh: productVM.getAllRequest,
                  //  () async {
                  //   await Provider.of<ProductViewModel>(context, listen: false)
                  //       .getAllRequest();
                  // },
                  child: ListView.builder(
                    itemCount: productVM.request.length,
                    itemBuilder: (context, index) {
                      var req = productVM.request[index];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            "${ApiClient.baseImageUrl}${req.product!.image!}",
                                          ),
                                          onError: (exception, stackTrace) =>
                                              Container(
                                                height: 160,
                                                width: double.infinity,
                                                color: Colors.grey[200],
                                                child: Icon(Icons.broken_image,
                                                    size: 60,
                                                    color: Colors.grey),
                                              ),
                                          fit: BoxFit.cover),
                                    ),
                                  ),

                                  // CircleAvatar(
                                  //     backgroundImage: NetworkImage(
                                  //   req.product!.image!,
                                  // )
                                  //     //radius: 24,
                                  //     ),
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
                                            Text(req.product?.name ?? "",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: getStatusColor(
                                                    req.status ?? ""),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(req.status ?? "",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(req.product!.price.toString(),
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
                              Text("Owner Information",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.person, size: 20),
                                  SizedBox(width: 6),
                                  Text("${req.owner?.fullName}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined, size: 20),
                                  SizedBox(width: 6),
                                  Text("${req.owner?.area}",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(Icons.email, size: 20),
                                  SizedBox(width: 6),
                                  Text(req.owner?.email ?? "",
                                      style: TextStyle(fontSize: 16)),
                                ],
                              ),
                              SizedBox(height: 10),
                              if (req.status == 'accepted')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, bottom: 10),
                                  child: Center(
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 40),
                                        backgroundColor: Colors.blue[300],
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
                                            Icons.check_circle_outline_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("Rental Confirmed",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 2,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              if (req.status == 'pending')
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 14, bottom: 10),
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      bool confirm = await showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text("Cancel Request"),
                                          content: Text(
                                              "Are you sure you want to cancel this request?"),
                                          actions: [
                                            TextButton(
                                              child: Text("No"),
                                              onPressed: () =>
                                                  Navigator.pop(context, false),
                                            ),
                                            TextButton(
                                              child: Text("Yes"),
                                              onPressed: () =>
                                                  Navigator.pop(context, true),
                                            ),
                                          ],
                                        ),
                                      );

                                      if (confirm) {
                                        await Provider.of<ProductViewModel>(
                                                context,
                                                listen: false)
                                            .deleteRentalRequest(
                                                req.id!, context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.cancel_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Cancel Request",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
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
