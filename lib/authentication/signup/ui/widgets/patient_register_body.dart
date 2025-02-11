import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/authentication/signup/ui/widgets/patient_register_section.dart';

import 'register_navigation_section.dart';

import 'doctor_register_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/register_navigation_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/sitch_method_register_section.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/user_register_section.dart';

class PatientRigesterBody extends StatelessWidget {
  const PatientRigesterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          PatientRegisterSection(),
          RegisterNavigationSection(
            isdoctor: false,
          ),
        ],
      ),
    );
  }
}
