
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_reverse_arrow.dart';
import 'package:medify/onboarding_screen/ui/widgets/dots.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Dots(),
          Gap(40),
          Row(
            children: [
              ReverseArrow(
                onPressed: () {},
              ),
              Gap(30),
              GradientButton(
                onpressed: () {},
              ),
            ],
          ),
      ],
    );
  }
}