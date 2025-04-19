import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:medify/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/about%20us/ui/views/aboutus_view.dart';
import 'package:medify/authentication/congradulations/views/congradulations.dart';

import 'package:medify/authentication/signup/ui/views/register_as_patient.dart';
import 'package:medify/booking/ui/widgets/doctor_info.dart';
import 'package:medify/chat/ui/views/all_chats.dart';
import 'package:medify/chat/ui/views/messages_page.dart';
import 'package:medify/core/routing/app_router.dart';
import 'package:medify/doctors/ui/views/DoctorPublicProfile.dart';
import 'package:medify/doctors/ui/views/doc_view.dart';
import 'package:medify/doctors/ui/views/myappointment.dart';
import 'package:medify/feedback/feedback_view.dart';
import 'package:medify/heart%20diseases/ui/views/heart_diseases.dart';
import 'package:medify/helpers/tapProvider.dart';
import 'package:medify/profile/ui/views/MyAppointments_view.dart';
import 'package:medify/profile/ui/views/profile_view.dart';
import 'package:medify/profile/ui/views/public_profile.dart';
import 'package:medify/settings/ui/views/password_manager.dart';
import 'package:provider/provider.dart';
import 'authentication/login/ui/views/login_view.dart';
import 'authentication/signup/ui/views/intial_sign_up_view.dart';
import 'authentication/signup/ui/views/register_as_doctor.dart';
import 'booking/ui/views/booking.dart';
import 'bottom_nav/bottom_nav_screens.dart';
import 'favorite_docs/ui/views/FavoriteDoctors.dart';
import 'home/ui/views/home.dart';
import 'notification/ui/views/notification_page.dart';
import 'onboarding/ui/views/onboarding_view.dart';
import 'onboarding/ui/views/start_view.dart';
import 'settings/ui/views/settings.dart';

void main() {
  runApp(
    // this multi privider for bottom nav bar to work
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => tapProvider()),
      ],
      // child: gradeApp(),
      child: DevicePreview(
        enabled: true,
        builder: (context) => ChangeNotifierProvider(
          create: (context) => tapProvider(),
          child: const gradeApp(),
        ),
      ),
    ),
  );
}

class gradeApp extends StatelessWidget {
  const gradeApp({super.key});

  @override
  Widget build(BuildContext context) {
    // note that : we are working on iphone 12 pro max
    // do not delete this comment
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
