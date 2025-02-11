import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_reverse_arrow.dart';
import 'package:medify/core/routing/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../../../../onboarding/ui/widgets/dots.dart';
import '../../../congradulations/views/congradulations.dart';
//import 'package:medify/onboarding_screen/ui/widgets/dots.dart';

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
                        builder: (context) =>
                            Congratulations(isSignUp: false, isdoctor: true)));
              },
            ),
          ],
        ),
      ],
    );
  }
}
