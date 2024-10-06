import 'package:flutter/material.dart';

class CustomTextfieldLabel extends StatelessWidget {
  const CustomTextfieldLabel({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.black,
         fontFamily: 'Inter',
        fontWeight: FontWeight.w900,
      
       
      ),
    );
  }
}
