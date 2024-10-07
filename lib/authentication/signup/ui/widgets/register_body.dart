import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/custom_button_with_border.dart';
import 'package:medify/authentication/login/ui/widgets/custom_filled_button.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield_label.dart';
import 'package:medify/authentication/login/ui/widgets/forgot_login_text.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_reverse_arrow.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/onboarding_screen/ui/widgets/dots.dart';

class RigesterBody extends StatelessWidget {
  const RigesterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          CustomTextfieldLabel(label: 'Full Name'),
          Gap(5),
          CustomTextField(
            hintText: 'Enter your full name',
            prefixIcon: Icons.email_outlined,
          ),
          CustomTextfieldLabel(label: 'Email'),
          Gap(5),
          CustomTextField(
            hintText: 'Enter your email',
            prefixIcon: Icons.lock_outline_rounded,
          ),
          CustomTextfieldLabel(label: 'Username'),
          Gap(5),
          CustomTextField(
            hintText: 'Enter your username',
            prefixIcon: Icons.email_outlined,
          ),
          CustomTextfieldLabel(label: 'Password'),
          Gap(5),
          CustomTextField(
            hintText: 'Enter your password',
            prefixIcon: Icons.email_outlined,
          ),
          Gap(10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'I agree to all Term, Privacy Policy and fees',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff667085),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Gap(15),
          CustomFilledButton(text: 'Sign up'),
          Gap(10),
          Align(
            alignment: Alignment.center,
            child: Text(
              'OR',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Gap(15),
          CustomButtonWithBorder(
            icon: Assets.assetsImagesGoogle,
            text: 'Sign in with Google',
          ),
          Gap(7),
          CustomButtonWithBorder(
              icon: Assets.assetsImagesfacebook, text: 'Sign in with Facebook'),
          Gap(25),
          Dots(),
          Gap(30),
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
          Gap(18),
        ],
      ),
    );
  }
}
