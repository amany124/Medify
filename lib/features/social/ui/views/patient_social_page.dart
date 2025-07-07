import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/views/patient_social_view.dart';

import '../../../../core/utils/keys.dart';

class PatientSocialPage extends StatelessWidget {
  const PatientSocialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SocialCubit>()
        ..getPatientSocialPosts(
          token: CacheManager.getData(key: Keys.token) ?? '',
        ),
      child: const PatientSocialView(),
    );
  }
}
