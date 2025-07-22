import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/meaasages_view.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/rent_product_detail_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/widgets/car_card_widget.dart';
import 'package:provider/provider.dart';

class RenterHomeScreen extends StatefulWidget {
  const RenterHomeScreen({super.key});

  @override
  State<RenterHomeScreen> createState() => _RenterHomeScreenState();
}

class _RenterHomeScreenState extends State<RenterHomeScreen> {
  @override
  void initState() {
    Provider.of<ProductViewModel>(context, listen: false).getAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final v = Provider.of<ProfileViewModel>(context);
    v.loadUserData();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 1,
          leadingWidth: double.infinity,
          toolbarHeight: 80,
          leading: ListTile(
            leading: const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                "https://img.freepik.com/free-photo/portrait-white-man-isolated_53876-40306.jpg",
              ),
            ),
            title: Text(
              "Hey, ${v.fullName ?? "Loading"}",
              style: const TextStyle(
                fontSize: 20,
                wordSpacing: 2,
                fontWeight: FontWeight.bold,
                color: blueColor,
              ),
            ),
          ),
          actions: [
            InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessagesScreen(),
                    )),
                child: Icon(Icons.chat))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: Provider.of<ProductViewModel>(context, listen: false)
              .getAllProducts,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              const SizedBox(
                height: 50,
                child: SearchBar(
                  leading: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Icon(Icons.search),
                  ),
                  hintText: "Search....",
                  backgroundColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 243, 243, 243),
                  ),
                  trailing: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.tune),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "All Rental Cars",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Consumer<ProductViewModel>(
                builder: (context, productVM, _) {
                  if (productVM.error != null) {
                    return Center(child: Text('Error: ${productVM.error}'));
                  }

                  if (productVM.products.isEmpty) {
                    return const Center(child: Text('No products found'));
                  }

                  return Column(
                    children: productVM.products.map((product) {
                      return CarCard(
                        onClick: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RentProductDetailsScreen(
                                productId: product.id,
                              );
                            },
                          ));
                        },
                        imageHeight: 140,
                        width: double.infinity,
                        imageUrl: product.image,
                        title: product.name,
                        variant: product.category,
                        city: product.location,
                        price: "Rs.${product.price.toString()}",
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
