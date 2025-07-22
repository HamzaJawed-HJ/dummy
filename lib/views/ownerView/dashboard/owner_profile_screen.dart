import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/widgets/profile_screen_widget.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        // Load user data when the screen is initialized
        profileViewModel.loadUserData();

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Profile",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            centerTitle: true,
            scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    profileViewModel.role ?? "Loading...",
                    style: TextStyle(color: blueColor, letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  const Center(
                    child: CircleAvatar(
                      radius: 60,
                      child: Icon(
                        Icons.person_rounded,
                        size: 80,
                        color: Color.fromARGB(255, 19, 111, 153),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Display user data (using profileViewModel)
                  Text(
                    profileViewModel.fullName ?? "Loading...",
                    style: TextStyle(color: blueColor, letterSpacing: 2, fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  _buildProfileDetailRow("Email", profileViewModel.email ?? "Loading..."),
                  _buildProfileDetailRow("Phone Number", profileViewModel.phoneNumber ?? "Loading..."),
                  _buildProfileDetailRow("CNIC", profileViewModel.cnic ?? "Loading..."),

                  SizedBox(height: 10),
                  Divider(height: 10),
                  ProfileWidget(
                    title: "Edit Profile",
                    icon: Icons.person_3,
                    onTap: () {
                      // Navigate to Edit Profile screen
                    },
                  ),
                  SizedBox(height: 10),
                  // Logout button
                  ListTile(
                    onTap: () => profileViewModel.logout(context),
                    leading: Container(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.key_sharp,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget for displaying profile details in rows
  Widget _buildProfileDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "$title: ",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color: blueColor), // Label text style
          ),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 26, color: TextColor), // Value text style
          ),
        ],
      ),
    );
  }
}
