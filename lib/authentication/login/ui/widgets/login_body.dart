import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/custom_button_with_border.dart';
import 'package:medify/authentication/login/ui/widgets/custom_filled_button.dart';
import 'package:medify/authentication/login/ui/widgets/custom_logo.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield_label.dart';
import 'package:medify/authentication/login/ui/widgets/forgot_login_text.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_reverse_arrow.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/onboarding_screen/ui/widgets/dots.dart';
import 'package:medify/onboarding_screen/ui/widgets/navigation_button.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(35),
          CustomTextfieldLabel(label: 'Email'),
          Gap(10),
          CustomTextField(
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
          ),
          Gap(10),
          CustomTextfieldLabel(label: 'Password'),
          Gap(10),
          CustomTextField(
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline_rounded,
          ),
          Gap(22),
          Align(
            alignment: Alignment.center,
            child: Text(
              'I agree to all Term, Privacy Policy and fees',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(23),
          CustomFilledButton(text: 'Login'),
          Gap(18),
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
          Gap(40),
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
      ),
    );
  }
}
