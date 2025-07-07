import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final IconData? prefixIcon;
  final double? height;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool isObscureText;
  const CustomTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.height = 50,
    this.onSaved,
    this.validator,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextFormField(
        obscureText: isObscureText,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12.0,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          
          hintText: hintText,
          hintStyle: const TextStyle(
              fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.w100),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.grey.withOpacity(0.8),
            size: 21,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
          filled: true,
          fillColor: Colors.white,
          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded border
            borderSide: const BorderSide(
              color: Color(0xffE9E9E9),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        onSaved: onSaved,
        validator: validator,
      ),
    );
  }
}
