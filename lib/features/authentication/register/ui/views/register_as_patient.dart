import 'package:flutter/material.dart';
import 'package:medify/features/authentication/register/ui/widgets/patient_register_body.dart';

import '../../../login/ui/widgets/custom_logo.dart';

class RegisterAsPatient extends StatelessWidget {
  const RegisterAsPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/auth_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const CustomLogo(),
        ),
        body: const SingleChildScrollView(
          child: PatientRigesterBody(),
        ),
      ),
    );
  }
}
