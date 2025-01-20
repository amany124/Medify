import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/utils/app_styles.dart';
import 'splash_logo.dart';

class SplashContainerChild extends StatelessWidget {
  const SplashContainerChild({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SplashLogo(),
        const Gap(15),
        Text(
          'Medify',
          style: AppStyles.bold32,
        ),
        const Gap(3),
        Text(
          'Medical App',
          style: AppStyles.semiBold14,
        )
      ],
    );
  }
}

