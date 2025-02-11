import 'package:flutter/material.dart';

import '../../../login/ui/widgets/custom_logo.dart';
import '../widgets/doctor_register_body.dart';

class RegisterAsDoctor extends StatelessWidget {
  const RegisterAsDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
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
          child: DoctorRigesterBody(),
        ),
      ),
    );
  }
}
