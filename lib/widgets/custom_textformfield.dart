import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Widget prefixIcon;
  final String? Function(String? value)? function;

  const CustomTextFieldWidget({
    this.function,
    required this.prefixIcon,
    required this.title,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => function!(value),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.v),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        labelText: title,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10.v),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10.v),
        ),
        prefixIcon: prefixIcon,
      ),
    );
  }
}
