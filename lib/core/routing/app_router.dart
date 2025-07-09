import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/features/HeartAnaysis/ui/views/heart_analysis_page.dart';
import 'package:medify/features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'package:medify/features/ProfileScreen/ui/views/private_profile_screen.dart';
import 'package:medify/features/Scheduling/views/Scheduling.dart'
    show ScheduleTimingsPage;
import 'package:medify/features/about%20us/ui/views/aboutus_view.dart';
import 'package:medify/features/authentication/login/ui/cubits/cubit/login_cubit.dart';
import 'package:medify/features/authentication/login/ui/views/login_view.dart';
import 'package:medify/features/authentication/register/data/repo/register_repo.dart';
import 'package:medify/features/authentication/register/ui/cubit/register_cubit/register_cubit.dart';
import 'package:medify/features/authentication/register/ui/views/intial_sign_up_view.dart';
import 'package:medify/features/authentication/register/ui/views/register_as_doctor.dart';
import 'package:medify/features/authentication/reset_password/data/repos/reset_password_repo.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_cubit.dart';
import 'package:medify/features/authentication/reset_password/presentation/views/request_reset_password_view.dart';
import 'package:medify/features/booking/data/repos/availability_cubit.dart';
import 'package:medify/features/booking/ui/views/booking.dart';
import 'package:medify/features/bottom_nav/bottom_nav_screens.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/doctors/data/models/doctor_model.dart';
import 'package:medify/features/doctors/ui/pages/favorite_doctors_screen.dart';
import 'package:medify/features/doctors/ui/views/DoctorPublicProfile.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/doctors/ui/views/myappointment.dart';
import 'package:medify/features/feedback/feedback_view.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_cubit.dart';
import 'package:medify/features/medical_records/ui/views/create_medical_record_page.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/onboarding/ui/views/onboarding_view.dart';
import 'package:medify/features/onboarding/ui/views/start_view.dart';
import 'package:medify/features/patient_appointment.dart';
import 'package:medify/features/profile/ui/views/MyAppointments_view.dart';
import 'package:medify/features/profile/ui/views/profile_view.dart';
import 'package:medify/features/profile/ui/views/public_profile.dart';
import 'package:medify/features/settings/ui/views/password_manager.dart';
import 'package:medify/features/settings/ui/views/settings.dart';
import 'package:medify/features/social/ui/views/socail_page.dart';
import 'package:medify/features/social/ui/widgets/create_post_Page.dart';

import '../../features/ProfileScreen/data/repos/profile_repo.dart';
import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/register/ui/views/register_as_patient.dart';
import '../../features/booking/data/repos/appointment_repo.dart';
import '../../features/chat/models/get_conversation_request_model.dart';
import '../../features/chat/ui/chat_cubit/chat_cubit.dart';
import '../../features/doctor_appointment.dart';
import '../../features/heart diseases/presentation/cubit/predict_disease_cubit.dart';
import '../../features/social/ui/views/socail_page.dart' show SocailPage;
import '../helpers/cache_manager.dart';
import '../services/api_service.dart';
import '../utils/keys.dart';

class AppRouter {
  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboardingScreen:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.createPostpage:
        return MaterialPageRoute(
          builder: (_) {
            final isEditing =
                (settings.arguments as Map<String, dynamic>)['isEditing'] ??
                    false;
            final content =
                (settings.arguments as Map<String, dynamic>)['contentText'];
            final postId =
                (settings.arguments as Map<String, dynamic>)['postId'];

            return CreatePostPage(
              isEditing: isEditing,
              contentText: content,
              postId: postId,
            );
          },
        );
      case Routes.intialScreen:
        return MaterialPageRoute(builder: (_) {
          if (LocalData.getIsLogin()) {
            return const BottomNavscreens();
          } else {
            return const OnboardingView();
          }
        });
      case Routes.startScreen:
        return MaterialPageRoute(builder: (_) => const StartView());
      case Routes.IntialSignUpView:
        return MaterialPageRoute(builder: (_) => const IntialSignUpView());
      case Routes.availability:
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
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => RegisterCubit(
                        RegisterRepoImpl(
                          apiServices: ApiServices(
                            Dio(),
                          ),
                        ),
                      ),
                    ),
                    BlocProvider(
                      create: (context) => getIt<PredictDiseaseCubit>(),
                    ),
                  ],
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
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetProfileCubit(
                    ProfileRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
                  ),
                  child: const PrivateProfileScreen(),
                ));

      case Routes.bottomNavThatHasAllScreens:
        return MaterialPageRoute(builder: (_) => const BottomNavscreens());

      case Routes.sidebar:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => GetProfileCubit(
                    ProfileRepoImpl(
                      apiServices: ApiServices(
                        Dio(),
                      ),
                    ),
                  ),
                  child: const ProfileView(),
                ));
      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const HeartAnalysisPage());
      case Routes.socialScreen:
        return MaterialPageRoute(builder: (_) => const SocailPage());
      case Routes.mainDoctorsScreen:
        return MaterialPageRoute(builder: (_) => const TopDoctorsView());
      case Routes.doctorPublicProfile:
        if (settings.arguments != null &&
            settings.arguments is Map<String, dynamic>) {
          final args = settings.arguments as Map<String, dynamic>;
          final doctorId = args['doctor'] as DoctorModel?;
          if (doctorId != null) {
            return MaterialPageRoute(
                builder: (_) => DoctorProfile(doctor: doctorId));
          }
        }
        return MaterialPageRoute(builder: (_) => const PublicProfile());
      case Routes.myAppointments:
        return MaterialPageRoute(builder: (_) => const AppointmentsView());
      case Routes.doctorAppointments:
        return MaterialPageRoute(builder: (_) => const MyAppointmentsPage());
      case Routes.appointment:
        return MaterialPageRoute(
            builder: (_) => AppointmentPage(
                  doctor: settings.arguments as DoctorModel,
                ));
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationView());
      case Routes.allChats:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (context) => getIt<ChatCubit>()
                    ..getConversation(
                      requestModel: GetConversationRequestModel(
                        token: CacheManager.getData(key: Keys.token) ?? '',
                      ),
                    ),
                  child: const AllChats(),
                ));

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case Routes.passwordManager:
        return MaterialPageRoute(builder: (_) => const PasswordManager());
      // case Routes.goodResult:
      //   return MaterialPageRoute(builder: (_) => const GoodResultPage());
      // case Routes.badResult:
      //   return MaterialPageRoute(builder: (_) => const BadResultPage());
      case Routes.feedbackScreen:
        return MaterialPageRoute(builder: (_) => const FeedbackView());
      case Routes.favoriteDoctors:
        return MaterialPageRoute(builder: (_) => const FavoriteDoctorsScreen());
      case Routes.aboutUs:
        return MaterialPageRoute(builder: (_) => const AboutusView());
      case Routes.patientAppointments:
        return MaterialPageRoute(builder: (_) => const PatientAppointment());
      case Routes.doctorAppointment:
        return MaterialPageRoute(builder: (_) => const DoctorAppointment());
      case Routes.resetPasswordRequest:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => ResetPasswordCubit(
              resetPasswordRepo: ResetPasswordRepoImpl(
                apiServices: ApiServices(Dio()),
              ),
            ),
            child: const RequestResetPasswordView(),
          ),
        );
      case Routes.createMedicalRecord:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<MedicalRecordsCubit>(),
            child: CreateMedicalRecordPage(
              appointment: settings.arguments as dynamic,
            ),
          ),
        );
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
