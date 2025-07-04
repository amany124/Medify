import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medify/features/chat/repo/chat_repo.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

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
        getIt(),
      ));
}
