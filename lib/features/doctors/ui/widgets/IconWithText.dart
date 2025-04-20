import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_styles.dart';

class CustomIconWithText extends StatelessWidget {
  const CustomIconWithText({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(
            0xff1877F2,
          ),
          size: 14,
        ),
        const Gap(5),
        Text(
          text,
          style: AppStyles.regular10.copyWith(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}


