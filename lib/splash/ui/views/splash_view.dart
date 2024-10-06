import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/app_images.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.assetsImagesSplashBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.assetsImagesAppLogo,
              height: 120,
            ),
            const Gap(15),
            const Text(
              'Medify',
              style: TextStyle(
                fontSize: 32,
                color: Color(0xff223A6A),
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(3),
            const Text(
              'Medical App',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff223A6A),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
