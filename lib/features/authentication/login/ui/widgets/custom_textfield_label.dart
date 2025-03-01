import 'package:flutter/material.dart';

class CustomTextfieldLabel extends StatelessWidget {
  const CustomTextfieldLabel({
    super.key,
    required this.label,
    this.fontsize = 13.7,
  });
  final String label;
  final double? fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontsize,
        color: Colors.black,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w900,
      ),
    );
  }
}
