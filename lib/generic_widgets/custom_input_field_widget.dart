import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_renterra_frontend/core/constants/app_colors.dart';

// ignore: must_be_immutable
class CustomInputField extends StatelessWidget {
  String title, validation_text;
  IconData icon;
  TextEditingController controller;
  TextInputType inputType;
  FormFieldValidator<String>? customValidator;
  List<TextInputFormatter> ?inputformator; // Custom validator
  int? maxLine;

  CustomInputField(
      {super.key,
      required this.title,
      required this.icon,
      required this.controller,
      required this.inputType,
      required this.validation_text,
      this.customValidator,
      this.inputformator,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextFormField(
        inputFormatters: inputformator,
        maxLines: maxLine,
        controller: controller,
        decoration: InputDecoration(
          hintText: title,
          contentPadding: EdgeInsets.all(8),
          fillColor: Color(0xfff6f6f6),
          filled: true,
          prefixIcon: Icon(
            icon,
            color: Color.fromARGB(255, 121, 120, 120),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: blueColor, width: 3)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              //  color: blueColor
              color: Color(0xff323F4B),
            ),
          ),
        ),
        keyboardType: inputType,
        validator: (value) {
          if (value!.isEmpty) {
            return validation_text;
          }
          if (customValidator != null) {
            return customValidator!(
                value); // Use the custom validator if provided
          }
          return null;
        },
      ),
    );
  }
}
