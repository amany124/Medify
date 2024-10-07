
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/custom_button_with_border.dart';
import 'package:medify/authentication/login/ui/widgets/forgot_login_text.dart';
import 'package:medify/core/utils/app_images.dart';

class SwitchMethodSection extends StatelessWidget {
  const SwitchMethodSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         Align(
            alignment: Alignment.center,
            child: ForgotLogintext(
              text1: 'Forgot Login Details?  ',
              text2: 'Reset',
            ),
          ),
          Gap(10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'OR',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Gap(10),
          CustomButtonWithBorder(
            icon: Assets.assetsImagesGoogle,
            text: 'Sign in with Google',
          ),
          Gap(7),
          CustomButtonWithBorder(
              icon: Assets.assetsImagesfacebook, text: 'Sign in with Facebook'),
          Gap(18),
          Align(
            alignment: Alignment.center,
            child: ForgotLogintext(
              text1: 'Dont’t have an account?  ',
              text2: 'Now Sign Up',
            ),
          ),
      ],
    );
  }
}