import 'package:flutter/material.dart';

class ForgotLogintext extends StatelessWidget {
  final String text1;
  final String text2;

  const ForgotLogintext({super.key, required this.text1, required this.text2});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text1,
            style: const TextStyle(
                color: Colors.grey,
                fontSize: 14.9,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text2 ,
            style: const TextStyle(
                color: Color(0xff0958D9),
                fontSize: 14.9,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
