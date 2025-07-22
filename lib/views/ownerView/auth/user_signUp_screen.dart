import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_renterra_frontend/core/utlis/validator.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_app_button.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_dropdown.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_input_field_widget.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/user_viewModel/user_auth_viewModel.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cnicController = TextEditingController();
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool agreeTerms = false;
  String? selectedArea;
  XFile? selectedImage;

  final List<String> areas = [
    "North Karachi",
    "Nazimabad",
    "Gulshan-e-Iqbal",
    "Saddar",
    "Bahadurabad"
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _cnicController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(UserAuthViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    await viewModel.registerUser(
      fullName: _fullNameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      area: selectedArea!,
      cnic: _cnicController.text.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserAuthViewModel>(
      builder: (context, viewModel, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),

                    RichText(
                      text: const TextSpan(
                        text: 'Register as a ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'User',
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),

                    // const Text(
                    //   "Register as a User",
                    //   style: TextStyle(
                    //     fontSize: 24,
                    //     fontWeight: FontWeight.bold,
                    //     color: Colors.black87,
                    //   ),
                    // ),
                    const SizedBox(height: 8),
                    const Text(
                      "Fill your information below or register",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: const Text(
                        "Full Name",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    CustomInputField(
                      title: "Full Name",
                      controller: _fullNameController,
                      icon: Icons.person,
                      inputType: TextInputType.name,
                      validation_text: "Full name is required",
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: const Text(
                        "Phone Number",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    CustomInputField(
                      title: "Phone Number",
                      controller: _phoneController,
                      icon: Icons.phone,
                      inputType: TextInputType.phone,
                      inputformator: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      validation_text: "Phone number is required",
                      customValidator: Validator.validatePhone,
                    ),
                    ContainerText(stringText: "Email"),
                    CustomInputField(
                      title: "Email Address",
                      controller: _emailController,
                      icon: Icons.email_outlined,
                      inputType: TextInputType.emailAddress,
                      validation_text: "Email is required",
                      customValidator: Validator.validateEmail,
                    ),
                    ContainerText(stringText: "Password"),

                    CustomInputField(
                      title: "Password",
                      controller: _passwordController,
                      icon: Icons.remove_red_eye_outlined,
                      inputType: TextInputType.visiblePassword,
                      validation_text: "Password is required",
                      customValidator: Validator.validatePassword,
                    ),
                    ContainerText(stringText: "CNIC Number"),

                    CustomInputField(
                      title: "CNIC Number",
                      controller: _cnicController,
                      icon: Icons.credit_card,
                      inputformator: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      inputType: TextInputType.number,
                      validation_text: "CNIC is required",
                      customValidator: Validator.validateCNIC,
                    ),
                    // ContainerText(stringText: "Image"),

                    // CustomImagePicker(
                    //   title: "CNIC",
                    //   imageFile: selectedImage != null
                    //       ? File(selectedImage!.path)
                    //       : null,
                    //   onTap: () async {
                    //     final picked =
                    //         await HelperFunctions.pickImageFromCamera();
                    //     if (picked != null) {
                    //       setState(() => selectedImage = picked);
                    //     }
                    //   },
                    // ),
                    ContainerText(stringText: "Area"),
                    CustomDropdown(
                      hint: "Select Area",
                      items: areas,
                      selectedValue: selectedArea,
                      onChanged: (value) {
                        setState(() {
                          selectedArea = value!;
                        });
                      },
                    ),
                    // CustomPasswordField(
                    //   hint: "Password",
                    //   controller: _passwordController,
                    //   validationText: "Password is required",
                    // ),

                    const SizedBox(height: 5),

                    CustomAppButton(
                      title: "Sign Up",
                      isloading: viewModel.isLoading,
                      onPress: () => _submitForm(viewModel),
                    ),

                    // Row(
                    //   children: [
                    //     const Divider(height: 32),
                    //     Text("OR"),
                    //     const Divider(height: 32)
                    //   ],
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.userLoginScreen);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(color: blueColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ContainerText extends StatelessWidget {
  String stringText;
  ContainerText({super.key, required this.stringText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(left: 20),
      child: Text(
        stringText,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
