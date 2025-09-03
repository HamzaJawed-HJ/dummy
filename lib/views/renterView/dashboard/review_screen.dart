import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final String agreementId;

  const ReviewScreen({super.key, required this.agreementId});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Write a Review")),
      body: Column(
        children: [
          const Center(
            child: Text("Review Screen Content Here"),
          ),
          Text("Agreement ID: ${widget.agreementId}"),
        ],
      ),
    );
  }
}
