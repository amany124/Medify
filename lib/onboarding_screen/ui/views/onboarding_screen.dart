import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/onboarding_screen/ui/widgets/dots.dart';
import 'package:medify/onboarding_screen/ui/widgets/text_scetion.dart';

import '../widgets/doctor_image.dart';
import '../widgets/navigation_button.dart';

class onboardingView extends StatelessWidget {
  const onboardingView({super.key});

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
            const Gap(3),
            const Text(
              'Medify',
              style: TextStyle(
                color: Color(0xff223A6A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          doctorImage(),
          Gap(50),
          TextScetion(),
          Gap(60),
          Dots(),
          Gap(80),
          NavigationButton(),
        ],
      ),
    );
  }
}
