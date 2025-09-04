import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_input_field_widget.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/review_viewmodel.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  final String agreementId;
  final String ownerName;
  final String ownerImageUrl;

  const ReviewScreen({
    super.key,
    required this.agreementId,
    required this.ownerName,
    required this.ownerImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Review"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<ReviewViewmodel>(
            builder: (context, reviewVM, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // const SizedBox(height: 20),
                  const Text(
                    "Write Review",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 50),
                  // Owner profile picture
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: ownerImageUrl.isNotEmpty
                          ? NetworkImage(ownerImageUrl)
                          : null,
                      child: ownerImageUrl.isEmpty
                          ? Text(
                              ownerName.isNotEmpty
                                  ? ownerName[0].toUpperCase()
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
                  // Owner name
                  Text(
                    ownerName,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Title

                  // Rating stars
                  StarRating(
                    rating: reviewVM.rating.toDouble(),
                    onRatingChanged: (rating) {
                      reviewVM.updateRating(rating.toInt());
                    },
                    starCount: 5,
                    size: 50,
                    color: Colors.amber,
                    borderColor: Colors.grey,
                  ),
                  const SizedBox(height: 20),
                  // Comment text field

                  SizedBox(
                    height: 150,
                    child: TextField(
                      maxLines: null,
                      expands: true,
                      onChanged: (value) => reviewVM.updateComment(value),
                      decoration: InputDecoration(
                        hintText: "Write your feedback here...",
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(12),
                        // ),
                        contentPadding: const EdgeInsets.all(12),

                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 70),
                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Later: integrate with API
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Submitted review: ${reviewVM.rating} stars, '${reviewVM.comment}'",
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0277BD),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
