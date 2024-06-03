import 'package:flutter/material.dart';
import 'package:travelwave_mobile/constants.dart';

class CustomPasswordField extends StatefulWidget {
  final String hint;
  final TextEditingController controller;
  const CustomPasswordField(
      {super.key, required this.hint, required this.controller});

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.h, vertical: 6.v),
      child: TextField(
        controller: widget.controller,
        obscureText: !isClicked,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: PrimaryColors.gray200,
                width: 1.5,
                style: BorderStyle.solid),
          ),
          hintText: widget.hint,
          hintStyle: Theme.of(context).textTheme.titleSmall,
          // fillColor: Theme.of(context).colorScheme.background,
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: PrimaryColors.gray200,
                width: 1.5,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: PrimaryColors.gray200, width: 1.5),
            borderRadius: BorderRadius.circular(10.0),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isClicked
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: PrimaryColors.gray500,
            ),
            onPressed: () {
              setState(() {
                isClicked = !isClicked;
              });
              // Handle visibility toggle
            },
          ),
        ),
      ),
    );
  }
}
