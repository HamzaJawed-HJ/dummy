// File: edit_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade400)),
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
              const SizedBox(height: 20),
              const Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _CustomInputField(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  hintText: 'Hamza Jawed'),
              const SizedBox(height: 24),
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _CustomInputField(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  hintText: 'hamzajawed@email.com'),
              const SizedBox(height: 24),
              const Text(
                "Shop Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _CustomInputField(
                  prefixIcon: Icon(
                    Icons.add_business_rounded,
                    color: Colors.blue,
                  ),
                  hintText: 'Shop Address'),
              const SizedBox(height: 24),
              const Text(
                "Shop Address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              _CustomInputField(
                  prefixIcon: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                  hintText: 'Shop Address'),
            ],
          ),
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
            onPressed: () {},
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
  final String hintText;
  final Widget prefixIcon;
  const _CustomInputField({required this.hintText, required this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: hintText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
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
