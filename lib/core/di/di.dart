import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/cubits/delete_post_cubit/delete_post_cubit.dart';
import 'package:medify/features/social/ui/cubits/update_post_cubit/update_post_cubit.dart';

import '../../features/authentication/login/data/repos/login_repo.dart';
import '../../features/authentication/login/ui/cubits/cubit/login_cubit.dart';
import '../../features/authentication/register/data/repo/register_repo.dart';
import '../../features/authentication/register/ui/cubit/register_cubit/register_cubit.dart';
import '../../features/social/data/repos/social_repo.dart';
import '../../features/social/ui/cubits/create_post_cubit/create_post_cubit.dart';
import '../../features/social/ui/cubits/get_posts_cubit/get_posts_cubit.dart';
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
}
