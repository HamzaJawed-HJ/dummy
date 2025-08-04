import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/validator.dart';
import 'package:fyp_renterra_frontend/data/networks/api_client.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/owner_profile_viewModel.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final ScrollController scrollController = ScrollController();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final shopNameController = TextEditingController();
  final shopAddressController = TextEditingController();
  OwnerProfileViewModel? ownerVM;
  @override
  void initState() {
    super.initState();
    setController();
  }

  void setController() async {
    ownerVM = Provider.of<OwnerProfileViewModel>(context, listen: false);
    await ownerVM?.loadOwnerData();

    nameController.text = ownerVM?.fullName ?? "";
    emailController.text = ownerVM?.email ?? "";
    shopAddressController.text = ownerVM?.shopAddress ?? "";
    shopNameController.text = ownerVM?.shopName ?? "";
  }

  @override
  void dispose() {
    // ownerVM?.cnicPicture = null;
    // ownerVM?.cnicImage = null;
    // ownerVM?.profileImage = null;
    // ownerVM?.profilePicture = null;
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ownerVM = Provider.of<OwnerProfileViewModel>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Consumer<OwnerProfileViewModel>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: InkWell(
                    onTap: value.pickProfileImage,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey.shade400),
                          ),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: value.profileImage != null
                                ? FileImage(value.profileImage!)
                                : (value.profilePicture != null &&
                                        value.profilePicture!.isNotEmpty)
                                    ? NetworkImage(ApiClient.baseImageUrl +
                                        value.profilePicture!) as ImageProvider
                                    : null,
                            child: value.profileImage == null &&
                                    (value.profilePicture == null ||
                                        value.profilePicture!.isEmpty)
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
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                            child: const Icon(
                              Icons.add_a_photo,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _CustomInputField(
                  validation_text: "Enter name",
                  controller: nameController,
                  prefixIcon: const Icon(Icons.person, color: Colors.blue),
                  hintText: 'New Name',
                ),
                const SizedBox(height: 24),
                const Text(
                  "Email",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _CustomInputField(
                  validation_text: "Email is required",
                  customValidator: Validator.validateEmail,
                  controller: emailController,
                  prefixIcon: const Icon(Icons.email, color: Colors.blue),
                  hintText: 'Email',
                ),
                const SizedBox(height: 24),
                const Text(
                  "Shop Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _CustomInputField(
                  validation_text: "Enter Shop name",
                  controller: shopNameController,
                  prefixIcon: const Icon(Icons.add_business_rounded,
                      color: Colors.blue),
                  hintText: 'New Shop name',
                ),
                const SizedBox(height: 24),
                const Text(
                  "Shop Address",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 8),
                _CustomInputField(
                  validation_text: "Enter Shop Address",
                  controller: shopAddressController,
                  prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                  hintText: 'New Shop address',
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade600,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              ownerVM.editProfile(
                context: context,
                email: emailController.text.trim(),
                fullName: nameController.text.trim(),
                profileImage: ownerVM.profileImage,
                shopAddress: shopAddressController.text.trim(),
                shopName: shopNameController.text.trim(),
              );
            },
            child: const Text(
              'Update Profile',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomInputField extends StatelessWidget {
  final String hintText, validation_text;
  final Widget prefixIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? customValidator;

  const _CustomInputField({
    required this.validation_text,
    this.customValidator,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return validation_text;
        }
        if (customValidator != null) {
          return customValidator!(value);
        }
        return null;
      },
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
