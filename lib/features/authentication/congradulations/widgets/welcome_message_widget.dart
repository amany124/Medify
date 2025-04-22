import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GradulationsText extends StatelessWidget {
  const GradulationsText({
    super.key,
    required this.text1,
    required this.text2,
    required this.text3,
  });
  final String text1;
  final String text2;
  final String text3;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text1,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(224, 255, 255, 255),
          ),
        ),
        Text(
          textAlign: TextAlign.center,
          text2,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(224, 255, 255, 255),
          ),
        ),
        const Gap(25),
        Text(
          textAlign: TextAlign.center,
          text3,
          style: const TextStyle(
            fontSize: 15,
            color: Color.fromARGB(224, 255, 255, 255),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
