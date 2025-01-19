import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/login/ui/widgets/navigation_section.dart';
import 'package:medify/authentication/login/ui/widgets/switch__method_section.dart';
import 'package:medify/authentication/login/ui/widgets/user_login_section.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(35),
          UserLoginSection(),
          Gap(18),
          SwitchMethodSection(),
          Gap(40),
          NavigationSection(),
        ],
      ),
    );
  }
}
