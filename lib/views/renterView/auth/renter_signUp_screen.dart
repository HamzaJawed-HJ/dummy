import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/core/utlis/helper_functions.dart';
import 'package:fyp_renterra_frontend/core/utlis/validator.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_app_button.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_dropdown.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_input_field_widget.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_loading_overlay.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_auth_viewModel.dart';
import 'package:provider/provider.dart';

class RenterSignUpScreen extends StatefulWidget {
  const RenterSignUpScreen({super.key});

  @override
  State<RenterSignUpScreen> createState() => _RenterSignUpScreenState();
}

class _RenterSignUpScreenState extends State<RenterSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _shopNameController = TextEditingController();
  final _shopAddressController = TextEditingController();
  final _cnicController = TextEditingController();
  final _passwordController = TextEditingController();

  bool agreeTerms = false;
  String? selectedArea;

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
    _emailController.dispose();
    _phoneController.dispose();
    _shopNameController.dispose();
    _shopAddressController.dispose();
    _cnicController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(RenterAuthViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;
    if (selectedArea == null) {
      HelperFunctions.showErrorSnackbar(context, "Please select your area.");
      return;
    }

    await viewModel.registerRenter(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
      shopName: _shopNameController.text.trim(),
      shopAddress: _shopAddressController.text.trim(),
      cnic: _cnicController.text.trim(),
      area: selectedArea!,
      password: _passwordController.text.trim(),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RenterAuthViewModel>(
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
                    const SizedBox(height: 20),
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
                            text: 'Renter',
                            style: TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Fill your shop information to get started.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ContainerText(stringText: "Full Name"),
                    CustomInputField(
                      title: "Full Name",
                      controller: _fullNameController,
                      icon: Icons.person,
                      inputType: TextInputType.name,
                      validation_text: "Full name is required",
                    ),
                    ContainerText(stringText: "Email"),
                    CustomInputField(
                      title: "Email Address",
                      controller: _emailController,
                      icon: Icons.email,
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
                    ContainerText(stringText: "Phone Number"),
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
                    ContainerText(stringText: "Shop Name"),
                    CustomInputField(
                      title: "Shop Name",
                      controller: _shopNameController,
                      icon: Icons.store,
                      inputType: TextInputType.text,
                      validation_text: "Shop name is required",
                    ),
                    ContainerText(stringText: "Shop Address"),
                    CustomInputField(
                      title: "Shop Address",
                      controller: _shopAddressController,
                      icon: Icons.location_on,
                      inputType: TextInputType.streetAddress,
                      validation_text: "Shop address is required",
                    ),
                    ContainerText(stringText: "CNIC Number"),
                    CustomInputField(
                      title: "CNIC Number",
                      controller: _cnicController,
                      inputformator: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(13),
                      ],
                      icon: Icons.credit_card,
                      inputType: TextInputType.number,
                      validation_text: "CNIC is required",
                      customValidator: Validator.validateCNIC,
                    ),
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
                    const SizedBox(height: 10),
                    CustomAppButton(
                      title: "Sign Up",
                      isloading: viewModel.isLoading,
                      onPress: () => _submitForm(viewModel),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     const VerticalDivider(
                    //       width: 32,
                    //       thickness: 3,
                    //     ),
                    //     Text("OR"),
                    //     const VerticalDivider(width: 32)
                    //   ],
                    // ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Already have an account? "),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.renterLoginScreen);
                          },
                          child: const Text("Sign In"),
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
  final String stringText;
  final EdgeInsets? padding;
  const ContainerText({super.key, this.padding, required this.stringText});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: padding ?? const EdgeInsets.only(left: 20),
      child: Text(
        stringText,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }
}
