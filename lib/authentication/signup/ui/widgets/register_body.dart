import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'register_navigation_section.dart';
import 'sitch_method_register_section.dart';
import 'user_register_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/register_navigation_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/sitch_method_register_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/user_register_section.dart';

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
