import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../login/ui/widgets/custom_filled_button.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/custom_filled_button.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/custom_textfield.dart';
//import 'package:graduation_project/features/authentication/login/ui/widgets/custom_textfield_label.dart';

class UserRegisterSection extends StatelessWidget {
  const UserRegisterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextfieldLabel(label: 'Full Name'),
        Gap(5),
        CustomTextField(
          hintText: 'Enter your full name',
          prefixIcon: Icons.person_outline_rounded,
        ),
        CustomTextfieldLabel(label: 'Email'),
        Gap(5),
        CustomTextField(
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
        ),
        CustomTextfieldLabel(label: 'Username'),
        Gap(5),
        CustomTextField(
          hintText: 'Enter your username',
          prefixIcon: Icons.person_outline_rounded,
        ),
        CustomTextfieldLabel(label: 'Password'),
        Gap(5),
        CustomTextField(
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline_rounded,
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
      ],
    );
  }
}
