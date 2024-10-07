import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/custom_button_with_border.dart';
import 'package:medify/authentication/login/ui/widgets/custom_filled_button.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield.dart';
import 'package:medify/authentication/login/ui/widgets/custom_textfield_label.dart';
import 'package:medify/authentication/login/ui/widgets/forgot_login_text.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/authentication/login/ui/widgets/navigate_reverse_arrow.dart';
import 'package:medify/authentication/login/ui/widgets/switch__method_section.dart';
import 'package:medify/authentication/signup/ui/widgets/register_navigation_section.dart';
import 'package:medify/authentication/signup/ui/widgets/sitch_method_register_section.dart';
import 'package:medify/authentication/signup/ui/widgets/user_register_section.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/onboarding_screen/ui/widgets/dots.dart';

class RigesterBody extends StatelessWidget {
  const RigesterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          UserRegisterSection(),
          Gap(10),
          SwitchMethodRegisterSection(),
          Gap(25),
         RegisterNavigationSection(),
          Gap(18),
        ],
      ),
    );
  }
}
