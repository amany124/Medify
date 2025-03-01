import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_styles.dart';

class ContainerText extends StatelessWidget {
  const ContainerText({
    super.key,
     required this.text1,
    required this.text2,
  });
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xffcbe7f5),
        //Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              text1,
              //'Medify',
              style: AppStyles.bold22.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          const Gap(3),
           Text(
            text2,
            // "We strive to provide innovative digital solutions for monitoring and diagnosing heart diseases, with the goal of improving patients' quality of life by enabling them to closely track their health, access medical consultations, and effectively connect with doctors. Our aim is to empower users to make informed health decisions and respond quickly to symptoms to maintain their well-being.",
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
