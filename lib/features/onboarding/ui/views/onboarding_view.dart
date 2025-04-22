import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/app_images.dart';
import '../widgets/inner_shadow.dart';
import '../widgets/introduction_card.dart';
import '../widgets/introwhitecard.dart';
import '../widgets/welcome_message.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff577CEF),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 1500),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(
                    Assets.assetsImagesLeftStack,
                    colorFilter: const ColorFilter.mode(
                      Color(0xff83BAF7),
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              FadeInDown(
                duration: const Duration(milliseconds: 1500),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InnerShadow(
                    offsetX: 1,
                    offsetY: -7,
                    blurRadius: 9,
                    color: Colors.black.withOpacity(0.25), // Shadow color
                    child: Transform.scale(
                      scale: 1.1,
                      child: SvgPicture.asset(
                        Assets.assetsImagesRightStack,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Gap(20),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              FadeInLeft(
                  duration: const Duration(milliseconds: 1500),
                  child: const IntroductionCard()),
              FadeInLeft(
                  duration: const Duration(milliseconds: 1500),
                  child: const IntroWhiteCard()),
              Positioned(
                right: -65,
                top: -110,
                bottom: 0,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Container(
                    height: 214,
                    width: 214,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff577CEF),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: -5,
                child: FadeInDown(
                  duration: const Duration(milliseconds: 1500),
                  child: Image.asset(
                    Assets.assetsImagesSmilingMaleDoctor,
                  ),
                ),
              )
            ],
          ),
          const Spacer(),
          SlideInUp(
              duration: const Duration(milliseconds: 3000),
              curve: Curves.easeInOut,
            child: const WelcomeMessageWidget()),
          const Gap(54),
        ],
      ),
    );
  }
}








