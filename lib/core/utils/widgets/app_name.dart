import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName(
      {super.key,
      required this.fontSize,
      required this.color,
      required this.fontWeight});
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  @override
  Widget build(BuildContext context) {
    return Text(
      'Medify',
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: 'ADLaMDisplay'),
    );
  }
}
