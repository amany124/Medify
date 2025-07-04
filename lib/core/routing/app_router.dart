import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/features/HeartAnaysis/ui/views/diseases_analysis.dart';
<<<<<<< HEAD
import 'package:medify/features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'package:medify/features/ProfileScreen/ui/views/private_profile_screen.dart';
import 'package:medify/features/Scheduling/views/Scheduling.dart'
    show ScheduleTimingsPage;
=======
<<<<<<< HEAD
import 'package:medify/features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'package:medify/features/ProfileScreen/ui/views/private_profile_screen.dart';
=======
import 'package:medify/features/ProfileScreen/ui/views/ProfileScreen.dart';
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import 'package:medify/features/about%20us/ui/views/aboutus_view.dart';
import 'package:medify/features/authentication/login/ui/cubits/cubit/login_cubit.dart';
import 'package:medify/features/authentication/login/ui/views/login_view.dart';
import 'package:medify/features/authentication/register/data/repo/register_repo.dart';
import 'package:medify/features/authentication/register/ui/cubit/register_cubit/register_cubit.dart';
import 'package:medify/features/authentication/register/ui/views/intial_sign_up_view.dart';
import 'package:medify/features/authentication/register/ui/views/register_as_doctor.dart';
<<<<<<< HEAD
import 'package:medify/features/booking/data/repos/availability_cubit.dart';
=======
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import 'package:medify/features/booking/ui/views/booking.dart';
import 'package:medify/features/bottom_nav/bottom_nav_screens.dart';
import 'package:medify/features/chat/models/messageModel.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/chat/ui/views/messages_page.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/doctors/ui/views/myappointment.dart';
import 'package:medify/features/favorite_docs/ui/views/FavoriteDoctors.dart';
import 'package:medify/features/feedback/feedback_view.dart';
import 'package:medify/features/heart%20diseases/ui/views/heart_diseases.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/onboarding/ui/views/onboarding_view.dart';
import 'package:medify/features/onboarding/ui/views/start_view.dart';
<<<<<<< HEAD
import 'package:medify/features/patient_appointment.dart';
=======
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import 'package:medify/features/profile/ui/views/MyAppointments_view.dart';
import 'package:medify/features/profile/ui/views/profile_view.dart';
import 'package:medify/features/profile/ui/views/public_profile.dart';
import 'package:medify/features/settings/ui/views/password_manager.dart';
import 'package:medify/features/settings/ui/views/settings.dart';
import 'package:medify/features/social/ui/views/social_view.dart';

<<<<<<< HEAD
import '../../features/ProfileScreen/data/repos/profile_repo.dart';
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/register/ui/views/register_as_patient.dart';
import '../../features/booking/data/repos/appointment_repo.dart';
import '../../features/doctor_appointment.dart';
=======
<<<<<<< HEAD
import '../../features/ProfileScreen/data/repos/profile_repo.dart';
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/register/ui/views/register_as_patient.dart';
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import '../services/api_service.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    // this argument to be passed to any screen like this (arguments as class name)
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.startScreen:
        return MaterialPageRoute(builder: (_) => const StartView());
      case Routes.IntialSignUpView:
        return MaterialPageRoute(builder: (_) => const IntialSignUpView());
<<<<<<< HEAD
      case Routes.availability:
        //ScheduleTimingsPage
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AvailabilityCubit(
                appointmentRepo: AppointmentRepoImpl(
              apiServices: ApiServices(
                Dio(),
              ),
            ))
              ..fetchAvailability(),
            child: const ScheduleTimingsPage(),
          ),
        );
=======

>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
      case Routes.signUpAsDoctor:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RegisterCubit(
                    RegisterRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
                  ),
                  child: const RegisterAsDoctor(),
                ));
      case Routes.signUpAsPatient:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => RegisterCubit(
                    RegisterRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
                  ),
                  child: const RegisterAsPatient(),
                ));
      case Routes.loginScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => LoginCubit(
                    LoginRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
                  ),
                  child: const LoginScreen(),
                ));
      case Routes.privateProfile:
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetProfileCubit(
                    ProfileRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
<<<<<<< HEAD
                  ),
                  child: const PrivateProfileScreen(),
                ));
=======
                  )
                    ..getPatientProfile()
                    ..getDoctorProfile(),
                  child: const PrivateProfileScreen(),
                ));
=======
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03

      case Routes.bottomNavThatHasAllScreens:
        return MaterialPageRoute(builder: (_) => const BottomNavscreens());
      case Routes.sidebar:
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetProfileCubit(
                    ProfileRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
<<<<<<< HEAD
                  ),
                  child: const ProfileView(),
                ));
=======
                  )
                    ..getPatientProfile()
                    ..getDoctorProfile(),
                  child: const ProfileView(),
                ));
=======
        return MaterialPageRoute(builder: (_) => const ProfileView());
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const HeartAnalysisPage());
      case Routes.socialScreen:
        return MaterialPageRoute(builder: (_) => const SocialScreen());
      case Routes.mainDoctorsScreen:
        return MaterialPageRoute(builder: (_) => const DocsView());

      case Routes.doctorPublicProfile:
        return MaterialPageRoute(builder: (_) => const PublicProfile());
      case Routes.myAppointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsView());

      case Routes.doctorAppointments:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsPage());
<<<<<<< HEAD
      case Routes.appointment:
=======
      case Routes.appointDate:
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
        return MaterialPageRoute(builder: (_) => const AppointmentPage());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case Routes.allChats:
        return MaterialPageRoute(builder: (_) => const AllChats());
      case Routes.messagesPage:
        return MaterialPageRoute(
            builder: (_) => MessagesPage(
                messageData: messageModel(
                    senderName: 'Amany',
                    messageContent: 'hi',
                    messageDate: DateTime(2023, 5, 1),
                    dateMessage: '14/5/2025')));

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.passwordManager:
        return MaterialPageRoute(builder: (_) => const PasswordManager());
      case Routes.heartDiseases:
        return MaterialPageRoute(builder: (_) => const HeartDiseases());
      case Routes.feedbackScreen:
        return MaterialPageRoute(builder: (_) => const FeedbackView());
      case Routes.favoritedoctors:
        return MaterialPageRoute(builder: (_) => const Favoritedoctors());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutusView());
<<<<<<< HEAD
      case Routes.patientAppointments:
        return MaterialPageRoute(builder: (_) => const PatientAppointment());
      case Routes.doctorAppointment:
        return MaterialPageRoute(builder: (_) => const DoctorAppointment());
=======

>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
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
