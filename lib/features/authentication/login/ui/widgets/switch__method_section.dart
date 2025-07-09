import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/features/authentication/login/ui/widgets/custom_button_with_border.dart';
import 'package:medify/features/authentication/login/ui/widgets/forgot_login_text.dart';

import '../../../../../core/routing/routes.dart';

class SwitchMethodSection extends StatelessWidget {
  const SwitchMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.center,
          child: ForgotLogintext(
            text1: 'Forgot Login Details?  ',
            text2: 'Reset',
            onTap: () => context.pushNamed(Routes.resetPasswordRequest),
          ),
        ),
        const Gap(10),
        const Align(
          alignment: Alignment.center,
          child: Text(
            'OR',
            style: TextStyle(fontSize: 15),
          ),
        ),
        const Gap(10),
        const CustomButtonWithBorder(
          icon: Assets.assetsImagesGoogle,
          text: 'Sign in with Google',
        ),
        const Gap(7),
        const CustomButtonWithBorder(
            icon: Assets.assetsImagesFacebook, text: 'Sign in with Facebook'),
        const Gap(18),
        Align(
          alignment: Alignment.center,
          child: ForgotLogintext(
            text1: 'Dont’t have an account?  ',
            text2: 'Now Sign Up',
            onTap: () => context.pushNamed(Routes.intialSignUpView),
          ),
        ),
      ],
    );
  }
}
