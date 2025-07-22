import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

// ignore: must_be_immutable
class CustomAppButton extends StatelessWidget {
  bool isloading;
  String title;

  VoidCallback onPress;
  CustomAppButton({
    super.key,
    required this.title,
    required this.onPress,
    this.isloading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: blueColor,
                fixedSize:
                    Size.fromWidth(MediaQuery.of(context).size.width * 0.8)),
            onPressed: onPress,
            child: isloading
                ? CircularProgressIndicator(
                    strokeWidth: 4,
                    color: Colors.white,
                  )
                : Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
