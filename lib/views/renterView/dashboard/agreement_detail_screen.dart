import 'package:flutter/material.dart';

class AgreementDetailScreen extends StatefulWidget {
  const AgreementDetailScreen({super.key});

  @override
  State<AgreementDetailScreen> createState() => _AgreementDetailScreenState();
}

class _AgreementDetailScreenState extends State<AgreementDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agreement Details'),
        centerTitle: true,
      ),
      body: Center(
        child: Text('Agreement Details Content Here'),
      ),
    );
  }
}