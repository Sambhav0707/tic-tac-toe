import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const BorderRadius borderRadius = BorderRadius.all(Radius.circular(17));
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(color: Colors.blueAccent, blurRadius: 3, spreadRadius: 3)
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: borderRadius),
          minimumSize: Size(
            width,
            50,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
