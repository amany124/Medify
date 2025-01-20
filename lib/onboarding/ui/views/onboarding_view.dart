import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';
import '../widgets/doctor_image.dart';
import '../widgets/navigation_button.dart';
import '../widgets/text_scetion.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.assetsImagesAppLogo,
              height: 50,
            ),
            const Gap(8),
            Text(
              'Medify',
              style: AppStyles.bold22.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          DoctorImage(),
          Gap(40),
          TextScetion(),
          Spacer(),
          NavigationButton(),
          Gap(30),
        ],
      ),
    );
  }
}
