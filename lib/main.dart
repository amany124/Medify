import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/helpers/tapProvider.dart';

import 'package:provider/provider.dart';

import 'ProfileScreen/ui/views/ProfileScreen.dart';
import 'about us/ui/views/aboutus_view.dart';
import 'authentication/login/ui/views/login_view.dart';
import 'authentication/signup/ui/views/register_view.dart';
import 'booking/ui/views/booking.dart';
import 'doctors/ui/views/doc_view.dart';
import 'favorite_docs/ui/views/FavoriteDoctors.dart';
import 'feedback/feedback_view.dart';
import 'notification/ui/views/notification_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => ChangeNotifierProvider(
        create: (context) => tapProvider(),
        child: const gradeApp(),
      ),
    ),
  );
}

class gradeApp extends StatelessWidget {
  const gradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: //AboutusView(),
      //HeartAnalysisPage(),
       NotificationView(),
      // Home(),
      //RegisterScreen(),
       //LoginScreen(),
      //SplashView(),
      // onboardingView(),
      //StartView(),
    );
  }
}
