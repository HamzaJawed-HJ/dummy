import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/core/utlis/session_manager.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    onload();
  }

  void onload() async {
    final profileVM = Provider.of<UserProfileViewModel>(context, listen: false);
    await profileVM.loadUserData();

    // ProfileViewModel obj=Provider.of(<ProfileViewModel>context,listen: false);
    //
    // final token = await SessionManager.getAccessToken();

    final response = await ApiClient.get(
        profileVM.role == 'owner' ? "/users/profile" : "/users/profile-renter",
        isToken: true);
    if (response['success'] == true) {
      Future.delayed(const Duration(seconds: 5), () {
        if (profileVM.role == "owner") {
          Navigator.pushReplacementNamed(
              context, RoutesName.renterDashboardScreen);
        } else {
          Navigator.pushReplacementNamed(
              context, RoutesName.UserDashboardScreen);
        }
      });
    } else {
      Navigator.pushReplacementNamed(context, RoutesName.onboardingScreen1);
    }

    // Navigate after 3 seconds to onboarding or home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Center(
            child: Image.asset(
              "assets/renterra logo.png",
              height: 250,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 70),
          Text(
            "Rent a Car with Ease",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Simple, fast, and secure car rentals",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
