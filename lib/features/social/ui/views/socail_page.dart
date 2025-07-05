import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/social/data/models/get_posts_request_model.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/views/social_view.dart';

import '../../../../core/utils/keys.dart';

class SocailPage extends StatelessWidget {
  const SocailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SocialCubit>()
        ..getAllPosts(
          requestModel: GetPostsRequestModel(
            doctorId: CacheManager.getData(key: Keys.userId) ?? '',
            token: CacheManager.getData(key: Keys.token) ?? '',
          ),
        ),
      child: const SocialView(),
    );
  }
}
