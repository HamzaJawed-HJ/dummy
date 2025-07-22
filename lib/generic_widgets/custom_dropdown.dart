import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? selectedValue;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    Key? key,
    required this.hint,
    required this.items,
    required this.onChanged,
    required this.selectedValue,
  }) : super(key: key);

  // If you want more control, wrap with SizedBox(width: MediaQuery.of(context).size.width * 0.9)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xfff6f6f6),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xff323F4B)),
          ),
        ),
        items: items
            .map((area) => DropdownMenuItem<String>(
                  value: area,
                  child: Text(area),
                ))
            .toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? "Please select $hint" : null,
      ),
    );
  }
}
