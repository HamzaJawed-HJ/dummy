// import 'dart:developer';

// import 'package:flutter/material.dart';

// class OwnersReviewScreen extends StatelessWidget {
//   final String ownerId;
//   final String ownerName;
//   final String ownerImageUrl;

//   const OwnersReviewScreen({super.key, required this.ownerId, required this.ownerName, required this.ownerImageUrl});

//   @override
//   Widget build(BuildContext context) {
//     log("Owner ID: $ownerId");
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Owner's Reviews"),
//       ),
//       body: Column(
//         children: [
//           // Text(ownerId),

//           // Owner profile picture
//                     Center(
//                       child: CircleAvatar(
//                         radius: 50,
//                         backgroundImage: ownerImageUrl.isNotEmpty
//                             ? NetworkImage(ownerImageUrl)
//                             : null,
//                         child: ownerImageUrl.isEmpty
//                             ? Text(
//                                 ownerName.isNotEmpty
//                                     ? ownerName[0].toUpperCase()
//                                     : "?",
//                                 style: const TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               )
//                             : null,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     // Owner name
//                     Text(
//                       ownerName,
//                       style: const TextStyle(
//                         fontSize: 24,
//                         color: Colors.blue,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart'; // for stars
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/review_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart'; // for date formatting

class OwnersReviewScreen extends StatefulWidget {
  final String ownerId;
  final String ownerName;
  final String ownerImageUrl;

  const OwnersReviewScreen({
    super.key,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImageUrl,
  });

  @override
  State<OwnersReviewScreen> createState() => _OwnersReviewScreenState();
}

class _OwnersReviewScreenState extends State<OwnersReviewScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ReviewViewmodel>(context, listen: false)
          .fetchReviews(widget.ownerId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewViewmodel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Owner's Reviews"),
      ),
      body: reviewProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Owner profile
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: widget.ownerImageUrl.isNotEmpty
                        ? NetworkImage(widget.ownerImageUrl)
                        : null,
                    child: widget.ownerImageUrl.isEmpty
                        ? Text(
                            widget.ownerName.isNotEmpty
                                ? widget.ownerName[0].toUpperCase()
                                : "?",
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.ownerName,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // const SizedBox(height: 15),

                // ✅ Average Rating UI
                if (reviewProvider.reviews.isNotEmpty)
                  Column(
                    children: [
                      RatingBarIndicator(
                        rating: reviewProvider.averageRating,
                        itemBuilder: (context, _) =>
                            const Icon(Icons.star, color: Colors.amber),
                        itemSize: 28,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${reviewProvider.averageRating.toStringAsFixed(1)} / 5.0 (${reviewProvider.reviews.length} reviews)",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),

                // Reviews list
                Expanded(
                  child: reviewProvider.reviews.isNotEmpty
                      ? ListView.builder(
                          itemCount: reviewProvider.reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviewProvider.reviews[index];

                            // Cast renter & product properly
                            final renter = review["renterId"];
                            final product = review["productId"];
                            final rating = review["rating"] ?? 0;
                            final comment = review["comment"] ?? "";
                            final createdAt =
                                DateTime.tryParse(review["createdAt"] ?? "");
                            final formattedDate = createdAt != null
                                ? DateFormat("dd MMM yyyy").format(createdAt)
                                : "";

                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Renter + rating
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            "${ApiClient.baseImageUrl}${renter["profilePicture"]}",
                                          ),
                                          radius: 25,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                renter["fullName"] ?? "",
                                                // renterName,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              RatingBarIndicator(
                                                rating: rating.toDouble(),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                itemSize: 18,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          formattedDate,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),

                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 14),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("Review:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16)),
                                                  Text(comment),
                                                ],
                                              ),
                                            ),

                                            const SizedBox(width: 10),
                                            // Product info
                                            Column(
                                              children: [
                                                // if (productImage.isNotEmpty)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    "${ApiClient.baseImageUrl}${product["image"]}",
                                                    width: 60,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  product["name"] ?? "",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),

                                    const SizedBox(height: 10),
                                    // Comment
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: Text(
                            "No Reviews Yet",
                            style: TextStyle(fontSize: 26, color: Colors.grey),
                          ),
                        ),
                ),

                SizedBox(height: 20),
              ],
            ),
    );
  }
}
