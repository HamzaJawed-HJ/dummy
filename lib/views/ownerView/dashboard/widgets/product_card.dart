// widgets/product_card.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/data/models/product_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback onView;
  final VoidCallback onEdit;

  const ProductCard({
    required this.product,
    required this.onView,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    print("${ApiClient.baseImageUrl}${product.image}");
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 3,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              '${ApiClient.baseImageUrl}${product.image}',
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                height: 160,
                width: double.infinity,
                color: Colors.grey[200],
                child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 14),
            child: Text(product.name,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text("Rs ${product.price} / ${product.timePeriod}",
                style: TextStyle(
                    color: Colors.blue[700], fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14),
            child: Text(product.location,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16)),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 14, bottom: 16, left: 10, right: 10),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onView,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade500,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("View",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text("Edit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
