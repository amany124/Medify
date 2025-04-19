// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:medify/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/ProfileScreen/ui/views/ProfileScreen.dart';
import 'package:medify/about%20us/ui/views/aboutus_view.dart';
import 'package:medify/authentication/login/ui/views/login_view.dart';
import 'package:medify/authentication/signup/ui/views/doctor_appointment.dart';
import 'package:medify/authentication/signup/ui/views/intial_sign_up_view.dart';
import 'package:medify/authentication/signup/ui/views/patient_appointment.dart';
import 'package:medify/authentication/signup/ui/views/register_as_doctor.dart';
import 'package:medify/authentication/signup/ui/views/register_as_patient.dart';
import 'package:medify/authentication/signup/ui/widgets/intial_sign_up_view_body.dart';
import 'package:medify/booking/ui/views/booking.dart';
import 'package:medify/bottom_nav/bottom_nav_screens.dart';
import 'package:medify/chat/models/messageModel.dart';
import 'package:medify/chat/ui/views/all_chats.dart';
import 'package:medify/chat/ui/views/messages_page.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/doctors/ui/views/doc_view.dart';
import 'package:medify/doctors/ui/views/myappointment.dart';
import 'package:medify/favorite_docs/ui/views/FavoriteDoctors.dart';
import 'package:medify/feedback/feedback_view.dart';
import 'package:medify/heart%20diseases/ui/views/heart_diseases.dart';
import 'package:medify/notification/ui/views/notification_page.dart';
import 'package:medify/onboarding/ui/views/onboarding_view.dart';
import 'package:medify/onboarding/ui/views/start_view.dart';
import 'package:medify/profile/ui/views/MyAppointments_view.dart';
import 'package:medify/profile/ui/views/profile_view.dart';
import 'package:medify/profile/ui/views/public_profile.dart';
import 'package:medify/settings/ui/views/password_manager.dart';
import 'package:medify/settings/ui/views/settings.dart';
import 'package:medify/social/ui/views/social_view.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    // this argument to be passed to any screen like this (arguments as class name)
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingView());
      case Routes.startScreen:
        return MaterialPageRoute(builder: (_) => StartView());
      case Routes.IntialSignUpView:
        return MaterialPageRoute(builder: (_) => IntialSignUpView());

      case Routes.signUpAsDoctor:
        return MaterialPageRoute(builder: (_) => RegisterAsDoctor());
      case Routes.signUpAsPatient:
        return MaterialPageRoute(builder: (_) => RegisterAsPatient());
      case Routes.showdocappointments:
        return MaterialPageRoute(builder: (_) => DoctorAppointment());
      case Routes.showpaintappointments:
        return MaterialPageRoute(builder: (_) => PatientAppointment());
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.privateProfile:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

      case Routes.bottomNavThatHasAllScreens:
        return MaterialPageRoute(builder: (_) => BottomNavscreens());
      case Routes.sidebar:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => HeartAnalysisPage());
      case Routes.socialScreen:
        return MaterialPageRoute(builder: (_) => SocialScreen());
      case Routes.mainDoctorsScreen:
        return MaterialPageRoute(builder: (_) => DocsView());

      case Routes.doctorPublicProfile:
        return MaterialPageRoute(builder: (_) => PublicProfile());
      case Routes.myAppointments:
        return MaterialPageRoute(builder: (_) => AppointmentsView());

      case Routes.doctorAppointments:
        return MaterialPageRoute(builder: (_) => MyAppointmentsPage());
      case Routes.appointDate:
        return MaterialPageRoute(builder: (_) => AppointmentPage());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => NotificationView());
      case Routes.allChats:
        return MaterialPageRoute(builder: (_) => AllChats());
      case Routes.messagesPage:
        return MaterialPageRoute(
            builder: (_) => MessagesPage(
                messageData: messageModel(
                    senderName: 'Amany',
                    messageContent: 'hi',
                    messageDate: DateTime(2023, 5, 1),
                    dateMessage: '14/5/2025')));

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsView());
      case Routes.passwordManager:
        return MaterialPageRoute(builder: (_) => PasswordManager());
      case Routes.heartDiseases:
        return MaterialPageRoute(builder: (_) => HeartDiseases());
      case Routes.feedbackScreen:
        return MaterialPageRoute(builder: (_) => FeedbackView());
      case Routes.favoritedoctors:
        return MaterialPageRoute(builder: (_) => Favoritedoctors());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => AboutusView());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Unknown route: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
