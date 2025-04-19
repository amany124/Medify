import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
//import 'package:graduation_project/core/theme/app_colors.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';

class CustomSignUpButton extends StatelessWidget {
  const CustomSignUpButton({
    super.key,
    this.onTap,
    required this.icon,
    required this.type,
  });
  final VoidCallback? onTap;
  final String icon;

  final String type;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 2,
        ),
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.secondaryColor.withOpacity(0.8),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 30,
            ),
            const Spacer(),
            Text(
              'Sign up as a $type',
              style: AppStyles.medium12,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
