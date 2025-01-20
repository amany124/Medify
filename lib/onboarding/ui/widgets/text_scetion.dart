import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';

import '../../../core/utils/app_styles.dart';

class TextScetion extends StatelessWidget {
  const TextScetion({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Join to our awesome community',
            style: AppStyles.bold22,
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Text(
            '" Welcome to Medify ! Your health journey starts here.We\'re here to support you with personalized care and easy access to medical professionals. Let’s take the first step towards better health together!"',
            style: AppStyles.regular16,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
