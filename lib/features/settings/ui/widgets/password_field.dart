import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String labelText;

  const PasswordField({super.key, required this.labelText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0XFF2260FF),
              ),
              borderRadius:BorderRadius.circular(20),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0XFF2260FF),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: const Icon(Icons.visibility_off), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }
}