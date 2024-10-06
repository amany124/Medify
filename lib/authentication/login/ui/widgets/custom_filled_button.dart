import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({super.key, required this.text});
 final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 56,
        minWidth: double.infinity,
        color: const Color(0xff1677FF),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        onPressed: () {},
        child:  Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            
          ),
        ));
  }
}
