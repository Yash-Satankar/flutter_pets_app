import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color? color;
  const CustomButton({super.key, required this.text, this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: color ?? Colors.blue,
            borderRadius: const BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
