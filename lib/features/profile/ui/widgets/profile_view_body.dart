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
    return BlocBuilder<GetProfileCubit, GetProfileState>(
      builder: (context, state) {
        if (state is GetProfileLoading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              ),
            ],
          );
        } else if (state is GetProfileFailure) {
          return Center(
            child: Text(
              state.failure.message,
              style: AppStyles.semiBold16.copyWith(
                color: Colors.red,
              ),
            ),
          );
        } else {
          // Success
          final cubit = context.read<GetProfileCubit>();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Stack(
                  children: [
                    cubit.urlImage.isEmpty
                        ? CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue.shade200,
                            child: Icon(Icons.person,
                                size: 50, color: Colors.blue),
                          )
                        : ProfileImage(
                            url: cubit.urlImage,
                          ),
                    const EditIcon(),
                  ],
                ),
                const Gap(8),
                Text(
                  cubit.name,
                  style: AppStyles.semiBold16.copyWith(
                    color: Colors.black,
                  ),
                ),
                const Gap(10),
                const ProfileItems(),
              ],
            ),
          );
        }
      },
    );
  }
}
