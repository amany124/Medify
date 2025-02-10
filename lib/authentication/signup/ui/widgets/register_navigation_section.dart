import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/navigate_gredient_button.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/navigate_reverse_arrow.dart';

import '../../../../onboarding/ui/widgets/dots.dart';
import '../../../login/ui/widgets/navigate_gredient_button.dart';
import '../../../login/ui/widgets/navigate_reverse_arrow.dart';

class RegisterNavigationSection extends StatelessWidget {
  const RegisterNavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Dots(),
        const Gap(30),
        Row(
          children: [
            ReverseArrow(
              onPressed: () {},
            ),
            const Gap(30),
            GradientButton(
              onpressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
