import 'package:flutter/material.dart';

class SizeHelper {
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 360;

  static double getResponsiveHeight(BuildContext context, double percent) =>
      screenHeight(context) * percent;

  static double getResponsiveWidth(BuildContext context, double percent) =>
      screenWidth(context) * percent;
}
