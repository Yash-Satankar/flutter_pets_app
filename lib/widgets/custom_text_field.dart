import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final IconData icon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyBoardType;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.hintText,
    this.suffixIcon,
    this.onTap,
    this.maxLines,
    this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.keyBoardType = TextInputType.text,
    this.errorText,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: TextField(
        readOnly: readOnly,
        controller: controller,
        keyboardType: keyBoardType,
        obscureText: obscureText,
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          errorText: errorText,
          prefixIcon: Icon(
            icon,
            size: 20,
          ),
          prefixIconColor: Colors.black,
          hintText: hintText,
          suffixIcon: GestureDetector(
              onTap: () {
                onTap;
              },
              child: Icon(suffixIcon)),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
