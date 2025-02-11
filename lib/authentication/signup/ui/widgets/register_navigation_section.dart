import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/navigate_gredient_button.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/navigate_reverse_arrow.dart';

import '../../../../onboarding/ui/widgets/dots.dart';
import '../../../congradulations/views/congradulations.dart';
import '../../../login/ui/widgets/navigate_gredient_button.dart';
import '../../../login/ui/widgets/navigate_reverse_arrow.dart';

class RegisterNavigationSection extends StatelessWidget {
  const RegisterNavigationSection({super.key,this.isdoctor});
  final bool? isdoctor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            ReverseArrow(
              onPressed: () {
                context.pushNamed(Routes.IntialSignUpView);
              },
            ),
            const Gap(30),
            GradientButton(
              label: 'sign up',
              onpressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Congratulations(isSignUp: true, isdoctor: isdoctor!)));
              },
            ),
          ],
        ),
      ],
    );
  }
}
