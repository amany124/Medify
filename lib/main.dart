import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/chat/ui/views/all_chats.dart';
import 'package:medify/chat/ui/views/messages_page.dart';
import 'package:medify/doctors/ui/views/DoctorPublicProfile.dart';
import 'package:medify/heart%20diseases/ui/views/heart_diseases.dart';
import 'package:medify/helpers/tapProvider.dart';
import 'package:provider/provider.dart';
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
      home:
          // IntialSignUpView(),
          //HeartAnalysisPage(),
          //NotificationView(),
          // Home(),
          //RegisterScreen(),
          //LoginScreen(),
          //StartView(),
          // OnboardingView(),
          NotificationView(),
    );
  }
}
