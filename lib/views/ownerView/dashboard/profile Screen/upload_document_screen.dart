import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_profile_viewModel.dart';
import 'package:provider/provider.dart';

class UploadDocumentScreen extends StatelessWidget {
  const UploadDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = Provider.of<UserProfileViewModel>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Upload Document',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<UserProfileViewModel>(
            builder: (context, profileVM, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Profile Picture",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 18),

              Center(
                child: GestureDetector(
                  onTap: profileViewModel.profilePicture == ""
                      ? profileVM.pickProfileImage
                      : () {},
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade400)),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: profileVM.profileImage != null
                              ? FileImage(profileVM.profileImage!)
                              : profileVM.profilePicture != ""
                                  ? NetworkImage(ApiClient.baseImageUrl +
                                      profileVM.profilePicture!)
                                  : null,

                          // profileVM.profilePicture != ""
                          //     ? NetworkImage(ApiClient.baseImageUrl +
                          //         profileVM.profilePicture!)
                          //     : profileVM.profileImage != null
                          //         ? FileImage(profileVM.profileImage!)
                          //         : null,
                          child: profileVM.profileImage != null ||
                                  profileVM.profilePicture != ""
                              ? null
                              : Icon(
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
              ),

              const SizedBox(height: 28),

              const Text(
                "CNIC Picture:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 18),

              DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(12),
                dashPattern: [6, 3],
                color: Colors.blue,
                strokeWidth: 1.5,
                child: GestureDetector(
                  onTap: (profileViewModel.cnicPicture == "")
                      ? () {
                          profileVM.cnicPickImage(context);
                        }
                      : () {},
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    // decoration: BoxDecoration(
                    //   shape: BoxShape.rectangle,
                    //   border: Border.all(color: Colors.blue),
                    //   borderRadius: BorderRadius.circular(12),
                    // ),

                    color: const Color(0xFFF9FAFB),
                    child: profileVM.cnicPicture != ""
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              "${ApiClient.baseImageUrl}${profileVM.cnicPicture!}"
                              // ApiClient.baseImageUrl + profileVM.cnicPicture!,
                              ,
                              fit: BoxFit.cover,
                            ),
                          )
                        : profileVM.cnicImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  profileVM.cnicImage!,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(Icons.image_outlined,
                                      size: 40, color: Colors.blue),
                                  SizedBox(height: 8),
                                  Text(
                                    'Upload Document Photo',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Tap to select from gallery',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                  ),
                ),
              ),
              // SizedBox.shrink(),
            ],
          );
        }),
      ),
      bottomNavigationBar: Visibility(
        visible: profileViewModel.cnicPicture == "" &&
            profileViewModel.profilePicture == "",
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                if (profileViewModel.cnicImage != null &&
                    profileViewModel.profileImage != null) {
                  profileViewModel
                      .uploadImages(
                    profileImage: profileViewModel.profileImage,
                    cnicImage: profileViewModel.cnicImage,
                    context: context,
                  )
                      .then(
                    (value) {
                      profileViewModel.getProfile(context: context);
                      // profileViewModel.profileImage = null;
                      // profileViewModel.profilePicture = null;
                      // profileViewModel.cnicImage = null;
                      // profileViewModel.cnicPicture = null;
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Upload Both image')),
                  );
                }
              },
              child: profileViewModel.isLoading
                  ? CircularProgressIndicator(
                      strokeWidth: 4,
                      color: Colors.white,
                    )
                  : const Text(
                      'Upload',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
