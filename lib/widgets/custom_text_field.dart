import 'package:flutter/material.dart';
import 'package:tic_tac_toe/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(color: Colors.blue.shade800, blurRadius: 5, spreadRadius: 2)
      ]),
      child: TextFormField(
        readOnly: isReadOnly,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: bgColor,
          filled: true,
        ),
      ),
    );
  }
}
