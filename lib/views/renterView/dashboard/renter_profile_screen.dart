import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile%20Screen/edit_profile_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile%20Screen/upload_document_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/renter_profile%20Screen/change_password_screen.dart';
import 'package:provider/provider.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/widgets/profile_screen_widget.dart'; // Assuming this is the profile widget you're using

class RenterProfileScreen extends StatelessWidget {
  const RenterProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        // Load user data when the screen is initialized
        profileViewModel.loadUserData();
        // log("profile picture:" + profileViewModel.profilePicture!);

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Profile",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            centerTitle: true,
            // scrolledUnderElevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 1, left: 5, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20),

                  Text(
                    profileViewModel.profilePicture ?? " ",
                    style: TextStyle(color: Colors.black),
                  ),

                  Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),

                          // profileViewModel.profilePicture==""?
                          child: const CircleAvatar(
                            radius: 60,
                            child: Icon(
                              Icons.person_rounded,
                              size: 80,
                              color: Color.fromARGB(255, 19, 111, 153),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 0,
                          child: Container(
                              padding: EdgeInsets.all(7),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: Icon(
                                size: 20,
                                Icons.add_a_photo,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Display user data (using profileViewModel)
                  Text(
                    profileViewModel.fullName ?? "Loading...",
                    style: TextStyle(
                        color: blueColor,
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                      border: Border.all(width: 2, color: Colors.grey),
                    ),
                    child: Text(
                      "${profileViewModel.role!.toUpperCase()}" ?? "Loading...",
                      style: const TextStyle(
                          color: blueColor,
                          letterSpacing: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    profileViewModel.email ?? "Loading...",
                    style: TextStyle(
                        color: blueColor,
                        letterSpacing: 2,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),

                  // _buildProfileDetailRow(
                  //     " ", profileViewModel.email ?? "Loading..."),
                  // _buildProfileDetailRow("Phone Number",
                  //     profileViewModel.phoneNumber ?? "Loading..."),
                  // _buildProfileDetailRow(
                  //     "CNIC", profileViewModel.cnic ?? "Loading..."),

                  SizedBox(height: 30),
                  Divider(height: 10),

                  ProfileWidget(
                    title: "Upload Document",
                    icon: Icons.document_scanner,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UploadDocumentScreen(),
                          ));
                      // Navigate to Edit Profile screen
                    },
                  ),
                  ProfileWidget(
                    title: "Edit Profile",
                    icon: Icons.person_3,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ));
                      // Navigate to Edit Profile screen
                    },
                  ),
                  SizedBox(height: 10),

                  ProfileWidget(
                    title: "Change Password",
                    icon: Icons.lock_open,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChangePasswordScreen(),
                          ));

                      // Navigate to Edit Profile screen
                    },
                  ),

                  SizedBox(height: 10),

                  ProfileWidget(
                    title: "Delete Account",
                    icon: Icons.delete,
                    onTap: () {
                      // Navigate to Edit Profile screen
                    },
                  ),

                  // SizedBox(height: 10),

                  // Logout button
                  ListTile(
                    onTap: () => profileViewModel.logout(context),
                    leading: Container(
                      padding: EdgeInsets.all(20),
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
            "$title:",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: blueColor), // Label text style
          ),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 26,
                color: TextColor), // Value text style
          ),
        ],
      ),
    );
  }
}
