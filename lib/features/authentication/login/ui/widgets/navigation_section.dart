import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/features/authentication/login/ui/widgets/navigate_reverse_arrow.dart';

import '../../../congradulations/views/congradulations.dart';
//import 'package:medify/features/onboarding_screen/ui/widgets/dots.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(40),
        Row(
          children: [
            ReverseArrow(
              onPressed: () {},
            ),
            const Gap(30),
            GradientButton(
              label: 'log into your Account',
              onpressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CongratulationsView(
                            userName: 'Doctor',
                            isSignUp: false,
                            isdoctor: true)));
              },
            ),
          ],
        ),
      ],
    );
  }
}
