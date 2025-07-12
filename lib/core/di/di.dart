import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medify/features/ProfileScreen/data/repos/profile_repo.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_cubit.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';
import 'package:medify/features/chat/repo/chat_repo.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/medical_records/data/repos/medical_records_repo.dart';
import 'package:medify/features/medical_records/data/repos/medical_records_repo_impl.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_cubit.dart';
import 'package:medify/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import '../../features/heart diseases/data/repos/predict_disease_repo.dart';
import '../../features/heart diseases/presentation/cubit/predict_disease_cubit.dart';
import '../../features/social/data/repos/social_repo.dart';
import '../services/api_service.dart';

final getIt = GetIt.instance;

setup() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt()));

  getIt.registerLazySingleton<SocialRepo>(() => SocialRepoImpl(
        apiServices: getIt(),
      ));

  getIt.registerLazySingleton<SocialCubit>(() => SocialCubit(
        getIt(),
      ));
  getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl(
        apiServices: getIt(),
      ));

  getIt.registerLazySingleton<ChatCubit>(() => ChatCubit(
        getIt<ChatRepo>(),
      ));
  getIt.registerLazySingleton<PredictDiseaseRepo>(
    () => PredictDiseaseRepoImpl(apiServices: getIt()),
  );
  getIt.registerLazySingleton<PredictDiseaseCubit>(
    () => PredictDiseaseCubit(getIt()),
  );

  // Appointment repository and notification cubit
  getIt.registerLazySingleton<AppointmentRepo>(
    () => AppointmentRepoImpl(apiServices: getIt()),
  );
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(appointmentRepo: getIt()),
  );

  // Medical records repository and cubit
  getIt.registerLazySingleton<MedicalRecordsRepo>(
    () => MedicalRecordsRepoImpl(apiServices: getIt()),
  );
  getIt.registerFactory<MedicalRecordsCubit>(
    () => MedicalRecordsCubit(medicalRecordsRepo: getIt()),
  );

  getIt.registerFactory<VerifyDoctorCubit>(
    () => VerifyDoctorCubit(profileRepo: getIt()),
  );
  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImpl(apiServices: getIt()),
  );

  getIt.registerFactory<GetProfileCubit>(
    () => GetProfileCubit(getIt()),
  );
}
