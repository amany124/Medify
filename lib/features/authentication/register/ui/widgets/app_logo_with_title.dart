import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/widgets/app_logo.dart';

class AppLogoWithTitle extends StatelessWidget {
  const AppLogoWithTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppLogo(
          height: 60,
        ),
        const Gap(5),
        Text(
          'Medify',
          style: AppStyles.bold16.copyWith(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
