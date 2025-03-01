import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';

import '../../../../core/utils/app_styles.dart';

class WelcomeMessageWidget extends StatelessWidget {
  const WelcomeMessageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.36),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8D9FD9),
            Color(0xFF6183EA),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 2.45),
            blurRadius: 2.45,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 7,
            width: 60,
            decoration: BoxDecoration(
              color: const Color(0xffD9D9D9),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const Gap(15),
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                textAlign: TextAlign.center,
                cursor: '💙',
                "Welcome to Medify\nYour healthcare solution platform.",
                textStyle: AppStyles.semiBold14.copyWith(
                  color: Colors.white,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.startScreen);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 17,
              ),
            ),
            child: Text(
              "Get Started",
              style: AppStyles.semiBold13.copyWith(
                color: const Color(0xff577CEF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
