import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/social/data/models/get_posts_request_model.dart';
import 'package:medify/features/social/data/repos/social_repo.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/cubits/create_post_cubit/create_post_cubit.dart';
import 'package:medify/features/social/ui/cubits/delete_post_cubit/delete_post_cubit.dart';
import 'package:medify/features/social/ui/cubits/get_posts_cubit/get_posts_cubit.dart';
import 'package:medify/features/social/ui/cubits/update_post_cubit/update_post_cubit.dart';
import 'package:medify/features/social/ui/views/social_view.dart';

class SocailPage extends StatelessWidget {
  const SocailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SocialCubit>()
        ..getAllPosts(
          requestModel: GetPostsRequestModel(
            doctorId: LocalData.getAuthResponseModel()!.user.id.toString(),
            token: LocalData.getAuthResponseModel()!.token,
          ),
        ),
      child: const SocialView(),
    );
  }
}
