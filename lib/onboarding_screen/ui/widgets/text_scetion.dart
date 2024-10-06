import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TextScetion extends StatelessWidget {
  const TextScetion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            'Join to our awesome community',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22,
              color: Color(0xff3E5A68),
            ),
              textAlign: TextAlign.center,
          ),
          Gap(5),
          Text(
            '" Welcome to Medify ! Your health journey starts here.We\'re here to support you with personalized care and easy access to medical professionals. Let\’s take the first step towards better health together!"',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
