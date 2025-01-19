
import 'package:flutter/material.dart';
import 'package:medify/authentication/login/ui/widgets/custom_logo.dart';
import 'package:medify/authentication/signup/ui/widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const CustomLogo(),
      ),
      body: const SingleChildScrollView(child: RigesterBody()),
    );
  }
}
