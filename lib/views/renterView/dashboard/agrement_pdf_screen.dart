// import 'package:flutter/material.dart';
// import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class AgreementPdfScreen extends StatelessWidget {
//   final String pdfUrl;

//   AgreementPdfScreen({required this.pdfUrl});

//   @override
//   Widget build(BuildContext context) {
//     final String baseUrl = ApiClient.basepdfUrl; // <- your backend domain
//     final String fullUrl = "$baseUrl$pdfUrl";

//     return Scaffold(
//       appBar: AppBar(title: Text("Agreement PDF")),
//       body: SfPdfViewer.network(fullUrl),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class AgreementPdfScreen extends StatefulWidget {
  final String pdfUrl;
  const AgreementPdfScreen({required this.pdfUrl});

  @override
  _AgreementPdfScreenState createState() => _AgreementPdfScreenState();
}

class _AgreementPdfScreenState extends State<AgreementPdfScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _downloadFile();
  }

  Future<void> _downloadFile() async {
    final response = await http.get(Uri.parse(widget.pdfUrl));
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/temp.pdf");
    await file.writeAsBytes(response.bodyBytes);
    setState(() {
      localPath = file. path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agreement PDF")),
      body: localPath == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPath!),
    );
  }
}
