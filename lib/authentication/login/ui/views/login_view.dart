import 'package:flutter/material.dart';
import 'package:medify/authentication/login/ui/widgets/custom_logo.dart';
import 'package:medify/authentication/login/ui/widgets/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image:  DecorationImage(
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
        body: const SingleChildScrollView(child: LoginBody()),
      ),
    );
  }
}
