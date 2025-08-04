import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_app_button.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_auth_viewModel.dart';
import 'package:provider/provider.dart';

class RentProductDetailsScreen extends StatelessWidget {
  final String productId;

  const RentProductDetailsScreen({required this.productId});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductViewModel>(context).getById(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: const TextStyle(
            fontSize: 20,
            wordSpacing: 2,
            fontWeight: FontWeight.bold,
            // color: blueColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              '${ApiClient.baseImageUrl}${product.image}',
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 250,
                color: Colors.grey[300],
                child: Icon(Icons.broken_image, size: 60),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Rs ${product.price} / ${product.timePeriod}",
                      style:
                          TextStyle(fontSize: 18, color: Colors.blue.shade700)),
                  SizedBox(height: 16),
                  _infoRow(Icons.category, "Category", product.category),
                  _infoRow(Icons.location_on, "Location", product.location),
                  _infoRow(Icons.timer, "Rental Period", product.timePeriod),
                  SizedBox(height: 16),
                  Text("Description",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(product.description),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Consumer<ProductViewModel>(builder: (context, viewModel, _) {
          return CustomAppButton(
            title: "Rent Now",
            isloading: viewModel.isLoading,
            onPress: () => viewModel.renteRequest(
              context: context,
              productId: product.id,
            ),
          );
        }),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue),
          SizedBox(width: 8),
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
