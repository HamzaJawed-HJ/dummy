import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/data/models/product_model.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';

class CarCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String variant;
  final String city;
  final String price;
  final bool isFeatured;
  final bool isInsured;
  final double? width, imageHeight;
  void Function()? onClick;

  VoidCallback onTapReviews;

  Owner owner;

  CarCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.variant,
      required this.onClick,
      required this.city,
      required this.price,
      this.isFeatured = false,
      this.isInsured = false,
      this.width,
      this.imageHeight,
      required this.owner,
      required this.onTapReviews});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      
      width: width ?? 180,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Container(
                  child: Image.network(
                    "${ApiClient.baseImageUrl}$imageUrl",
                    height: imageHeight ?? 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 160,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image,
                          size: 60, color: Colors.grey),
                    ),
                  ),
                ),
              ),
              if (isFeatured)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Featured",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
              if (isInsured)
                Positioned(
                  top: 8,
                  left: 85,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "Insured",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Divider(),
                const SizedBox(height: 8),
                // ✅ Owner row (profile + name + email)
                Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        "${ApiClient.baseImageUrl}${owner.profilePicture}", // owner picture
                      ),
                      onBackgroundImageError: (_, __) =>
                          const Icon(Icons.person, size: 32),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        owner.fullName,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //reviews icon and text
                    GestureDetector(
                      onTap: onTapReviews,
                      child: Row(
                        children: [
                          ...List<Widget>.generate(
                            3,
                            (index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 22,
                            ),
                          ),
                          Text(
                            "Reviews",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                Divider(),
                // ✅ Existing car details

                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18)),
                Text(variant, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      city,
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(price,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: blueColor)),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: onClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Rent Now",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
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
