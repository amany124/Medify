import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/custom_filled_button.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield_label.dart';

class UserLoginSection extends StatelessWidget {
  const UserLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
      ],
    );
  }
}