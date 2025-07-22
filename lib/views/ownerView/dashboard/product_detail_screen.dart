import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/models/product_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/productViewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/edit_product_screen.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel product;

  ProductDetailsScreen({required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // ProductModel? product;
  @override
  void initState() {
//  WidgetsBinding.instance.addPostFrameCallback((_) {

    //  product= Provider.of<ProductViewModel>(context).getById(widget.productId);

    // });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product.id);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade500,
        title: Text(
          "Product Details",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              '${ApiClient.baseImageUrl}${widget.product?.image}',
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
                  Text(widget.product?.name ?? "", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Rs ${widget.product?.price} / ${widget.product?.timePeriod}", style: TextStyle(fontSize: 18, color: Colors.blue.shade700)),
                  SizedBox(height: 16),
                  _infoRow(Icons.category, "Category", widget.product?.category ?? ""),
                  _infoRow(Icons.location_on, "Location", widget.product?.location ?? ""),
                  _infoRow(Icons.timer, "Rental Period", widget.product?.timePeriod ?? ""),
                  SizedBox(height: 16),
                  Text("Description", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text(widget.product?.description ?? ""),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Edit Product",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProductScreen(
                                  obj: widget.product!,
                                ),
                              ));
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Delete Product",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: Text("Confirm Deletion"),
                              content: Text("Are you sure you want to delete this product?"),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text("Cancel")),
                                TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text("Delete")),
                              ],
                            ),
                          );

                          if (confirmed == true) {
                            try {
                              await Provider.of<ProductViewModel>(context, listen: false).deleteProduct(widget.product.id, context);

                              Navigator.pop(context); // Navigate back after successful deletion
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Failed to delete product')),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
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
