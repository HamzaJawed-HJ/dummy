import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile%20Screen/change_password_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile%20Screen/edit_profile_screen.dart';
import 'package:fyp_renterra_frontend/views/ownerView/dashboard/profile%20Screen/upload_document_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/profile%20Screen/edit_user_profile_screen.dart';
import 'package:fyp_renterra_frontend/views/renterView/dashboard/widgets/profile_screen_widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    loadData();
    //  Provider.of<UserProfileViewModel>(context, listen: false).loadUserData();
    // TODO: implement initState
    super.initState();
  }

  loadData() async {
    await Provider.of<UserProfileViewModel>(context, listen: false)
        .loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    // final profileViewmodel = Provider.of<UserProfileViewModel>(context, listen: false).loadUserData();

    return Consumer<UserProfileViewModel>(
      builder: (context, profileViewModel, child) {
        // Load user data when the screen is initialized
        //  profileViewModel.loadUserData();
        // log("profile picture:" + profileViewModel.profilePicture!);
        // loadData();
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox.shrink(),
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
                  const SizedBox(height: 20),

                  // Text(
                  //   profileViewModel.profilePicture ?? " ",
                  //   style: const TextStyle(color: Colors.black),
                  // ),

                  Center(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey.shade400)),

                          // profileViewModel.profilePicture==""?
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: profileViewModel.profilePicture !=
                                    ""
                                ? NetworkImage(
                                    "${ApiClient.baseImageUrl}${profileViewModel.profilePicture!}"

                                    // ApiClient.baseImageUrlupload +
                                    //   profileViewModel.profilePicture!
                                    )
                                : profileViewModel.profileImage != null
                                    ? FileImage(profileViewModel.profileImage!)
                                    : null,
                            child: profileViewModel.profilePicture != null &&
                                    profileViewModel.profilePicture == ""
                                ? const Icon(
                                    Icons.person_rounded,
                                    size: 80,
                                    color: Color.fromARGB(255, 19, 111, 153),
                                  )
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 0,
                          child: Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.blue),
                              child: const Icon(
                                size: 20,
                                Icons.add_a_photo,
                                color: Colors.white,
                              )),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Display user data (using profileViewModel)
                  Text(
                    profileViewModel.fullName ?? "Loading...",
                    style: const TextStyle(
                        color: blueColor,
                        letterSpacing: 2,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade200,
                      border: Border.all(width: 2, color: Colors.grey),
                    ),
                    child: Text(
                      "${(profileViewModel.role ?? "").toUpperCase()}" ??
                          "Loading...",
                      style: const TextStyle(
                          color: blueColor,
                          letterSpacing: 2,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    profileViewModel.email ?? "Loading...",
                    style: const TextStyle(
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

                  const SizedBox(height: 30),
                  const Divider(height: 10),

                  ProfileWidget(
                    title: "Upload Document",
                    icon: Icons.document_scanner,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UploadDocumentScreen(),
                          ));
                      // Navigate to Edit Profile screen
                    },
                  ),
                  ProfileWidget(
                    title: "Edit Profile",
                    icon: Icons.person_3,
                    onTap: () {
                      if (profileViewModel.role == "owner") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ));
                        // Navigate to Edit Profile screen
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUSerProfileScreen(),
                            ));
                        // Navigate to Edit Profile screen
                      }
                    },
                  ),
                  const SizedBox(height: 10),

                  ProfileWidget(
                    title: "Change Password",
                    icon: Icons.lock_open,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChangePasswordScreen(),
                          ));

                      // Navigate to Edit Profile screen
                    },
                  ),

                  const SizedBox(height: 10),

                  ProfileWidget(
                    title: "Delete Account",
                    icon: Icons.delete,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text("Confirm Delete"),
                            content: const Text(
                                "Are you sure you want to delete your account? This action cannot be undone."),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(dialogContext)
                                      .pop(); // Close dialog
                                },
                              ),
                              TextButton(
                                child: const Text("Yes, Delete"),
                                onPressed: () async {
                                  Navigator.of(dialogContext)
                                      .pop(); // Close dialog
                                  profileViewModel.deleteAccount(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),

                  // SizedBox(height: 10),

                  // Logout button
                  ListTile(
                    onTap: () => profileViewModel.logout(context),
                    leading: Container(
                      padding: const EdgeInsets.all(20),
                      child: const Icon(
                        Icons.key_sharp,
                        color: Colors.red,
                        size: 25,
                      ),
                    ),
                    title: const Text(
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
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 26,
                color: blueColor), // Label text style
          ),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 26,
                color: TextColor), // Value text style
          ),
        ],
      ),
    );
  }
}
