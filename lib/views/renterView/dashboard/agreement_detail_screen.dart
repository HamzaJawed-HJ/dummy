import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/agreement_detail_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AgreementDetailScreen extends StatefulWidget {
  final String rentalRequestId;
  const AgreementDetailScreen({super.key, required this.rentalRequestId});

  @override
  State<AgreementDetailScreen> createState() => _AgreementDetailScreenState();
}

class _AgreementDetailScreenState extends State<AgreementDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<AgreementDetailViewModel>()
          .fetchDetail(widget.rentalRequestId);

      context.read<AgreementDetailViewModel>().resetDates();
    });
  }

  // void apiCall() async  {

  //   await Provider.of<AgreementDetailViewModel>(context, listen: false)
  //       .fetchAgreement(widget.rentalRequestId);
  // }

  @override
  Widget build(BuildContext context) {
    // apiCall();
    return Consumer<AgreementDetailViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Agreement Details",
                style: TextStyle(color: Colors.black)),
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              // : vm.errorMessage != null
              //     ? Center(
              //         child: Text(vm.errorMessage!,
              //             style: const TextStyle(color: Colors.red)))
              : vm.agreementData == null
                  ? const Center(child: Text("No data found"))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Owner: ${vm.agreementData?['owner']?['fullName'] ?? ''}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(
                              "Product: ${vm.agreementData?['product']?['name'] ?? ''}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                              "Price: ${vm.agreementData?['product']?['price'] ?? ''} PKR",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 20),

                          /// Pickup Date
                          ListTile(
                            title: Text(vm.pickupDate == null
                                    ? "Select Pickup Date"
                                    : "Pickup Date: ${DateFormat('dd MMM yyyy').format(vm.pickupDate!)}"

                                // style: const TextStyle(
                                //     fontSize: 16, color: Colors.black),
                                ),
                            trailing: const Icon(Icons.calendar_today,
                                color: Color(0xFF0277BD)),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );

                              print(picked.toString());
                              if (picked != null) vm.setPickupDate(picked);
                            },
                          ),

                          /// Return Date
                          ListTile(
                            title: Text(vm.returnDate == null
                                ? "Select Return Date"
                                : "Return Date: ${DateFormat('dd MMM yyyy').format(vm.returnDate!)}"),
                            trailing: const Icon(Icons.calendar_today,
                                color: Color(0xFF0277BD)),
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) vm.setReturnDate(picked);
                            },
                          ),

                          const Spacer(),

                          /// Proceed Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0277BD),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              onPressed: () {
                                vm.proceedAgreement(
                                    widget.rentalRequestId, context);
                                if (vm.errorMessage != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(vm.errorMessage!)),
                                  );
                                }
                              },
                              child: const Text("Proceed",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                            ),
                          ),
                        ],
                      ),
                    ),
        );
      },
    );
  }
}
