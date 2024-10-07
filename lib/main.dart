import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/authentication/login/ui/views/login_view.dart';
import 'package:medify/authentication/signup/ui/views/register_view.dart';

import 'package:medify/onboarding_screen/ui/views/onboarding_screen.dart';
import 'package:medify/start_screen/ui/views/start_view.dart';
import 'splash/ui/views/splash_view.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const gradeApp(),
    ),
  );
}

class gradeApp extends StatelessWidget {
  const gradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
      RegisterScreen(),
   // LoginScreen(),
      //SplashView(),
     // onboardingView(),
      //StartView(),
    );
  }
}
