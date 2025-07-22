import 'package:flutter/material.dart';
import 'dart:io';

class CustomImagePicker extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onTap;
  final String title;

  const CustomImagePicker({
    Key? key,
    required this.imageFile,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
            color: Color(0xfff6f6f6),

//            color: const Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: imageFile == null
                ? Text("Tap to Upload $title CNIC Image")
                : Image.file(imageFile!, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
