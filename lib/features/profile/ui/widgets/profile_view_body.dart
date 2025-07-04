import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/utils/keys.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'edit_icon.dart';
import 'profile_image.dart';
import 'profile_items.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({
    super.key,
  });

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = CacheManager.getData(key: Keys.role);
      print('role is $role');
      if (role == 'Doctor') {
        context.read<GetProfileCubit>().getDoctorProfile();
      } else {
        context.read<GetProfileCubit>().getPatientProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Stack(
            children: [
              ProfileImage(),
              EditIcon(),
            ],
          ),
          const Gap(8),
          BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return Center(
                    child: LoadingAnimationWidget.progressiveDots(
                  color: AppColors.primaryColor,
                  size: 30,
                ));
              } else if (state is GetProfileFailure) {
                return Text(
                  state.failure.message,
                  style: AppStyles.semiBold16.copyWith(
                    color: Colors.red,
                  ),
                );
              }
              return Text(
                BlocProvider.of<GetProfileCubit>(context).name,
                style: AppStyles.semiBold16.copyWith(
                  // color: AppColors.blueColor,
                  color: Colors.black,
                ),
              );
            },
          ),
          const Gap(10),
          const ProfileItems()
        ],
      ),
    );
  }
}
