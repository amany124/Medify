import 'package:flutter/material.dart';

class ReverseArrow extends StatelessWidget {
  final VoidCallback? onPressed;

  const ReverseArrow({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.0), // Rounded border
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: const Color(0xffF3F9FF), // Light blue background color
          borderRadius: BorderRadius.circular(16.0), // Rounded border
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Color(0xff1677FF), // Dark blue icon color
        ),
      ),
    );
  }
}
