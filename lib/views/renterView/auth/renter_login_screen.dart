import 'package:flutter/material.dart';
import 'package:fyp_renterra_frontend/core/utlis/validator.dart';
import 'package:fyp_renterra_frontend/routes/route_names.dart';
import 'package:fyp_renterra_frontend/viewModel/renter_viewModel/renter_auth_viewModel.dart';
import 'package:fyp_renterra_frontend/views/renterView/auth/renter_signUp_screen.dart';
import 'package:provider/provider.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_input_field_widget.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_app_button.dart';
import 'package:fyp_renterra_frontend/generic_widgets/custom_loading_overlay.dart';

class RenterLoginScreen extends StatefulWidget {
  const RenterLoginScreen({super.key});

  @override
  State<RenterLoginScreen> createState() => _RenterLoginScreenState();
}

class _RenterLoginScreenState extends State<RenterLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm(RenterAuthViewModel viewModel) async {
    if (!_formKey.currentState!.validate()) return;

    await viewModel.loginRenter(
      email: _emailController.text.trim(),
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
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Image(
                      image: AssetImage('assets/login page image.jpg'),
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      text: const TextSpan(
                        text: "Let's get started ! ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Renter',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: blueColor,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Enter your credentials to access your account.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 30),
                    ContainerText(stringText: "Email"),
                    CustomInputField(
                      title: "Email",
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
                      icon: Icons.lock_outline,
                      inputType: TextInputType.visiblePassword,
                      validation_text: "Password is required",
                      customValidator: Validator.validatePassword,
                    ),
                    const SizedBox(height: 10),
                    CustomAppButton(
                      title: "Sign In",
                      isloading: viewModel.isLoading,
                      onPress: () => _submitForm(viewModel),
                    ),
                    //                      const SizedBox(height: 10),
                    // Row(
                    //   children: [
                    //     const VerticalDivider(
                    //       width: 20,
                    //       thickness: 3,
                    //       color: Colors.black,
                    //     ),
                    //     Expanded(child: Text("OR")),
                    //     const VerticalDivider(width: 32)
                    //   ],
                    // ),
                    const Divider(
                      //                        height: 10,
                      endIndent: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't have an account?",
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.renterSignUpScreen);
                          },
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                    const Divider(
                      //                        height: 10,
                      endIndent: 20,
                    ),
                    const SizedBox(height: 5),

                    Container(
                      margin: EdgeInsets.only(
                          left: 30, right: 30, bottom: 5, top: 10),
                      child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              fixedSize: Size(330, 44)),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RoutesName.userLoginScreen);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Join  As a User ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 2,
                                    color: blueColor),
                              ),
                            ],
                          )),
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
