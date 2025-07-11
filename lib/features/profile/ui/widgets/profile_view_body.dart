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
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = CacheManager.getData(key: Keys.role);
      if (role == 'Doctor' || role == 'doctor') {
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
          // 👇 BlocBuilder حول الجزء اللي فيه الاسم والصورة فقط
          BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state is GetProfileLoading) {
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    LoadingAnimationWidget.threeArchedCircle(
                      color: AppColors.primaryColor,
                      size: 40,
                    ),
                    const Gap(20),
                  ],
                );
              } else if (state is GetProfileFailure) {
                return Column(
                  children: [
                    const SizedBox(height: 40),
                    Icon(Icons.error, color: Colors.red),
                    const Gap(8),
                    Text(
                      state.failure.message,
                      style: AppStyles.semiBold16.copyWith(color: Colors.red),
                    ),
                    const Gap(20),
                  ],
                );
              } else {
                final cubit = context.read<GetProfileCubit>();
                return Column(
                  children: [
                    Stack(
                      children: [
                        cubit.urlImage.isEmpty
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue.shade200,
                                child: const Icon(Icons.person,
                                    size: 50, color: Colors.blue),
                              )
                            : ProfileImage(url: cubit.urlImage),
                        const EditIcon(),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      cubit.name,
                      style: AppStyles.semiBold16.copyWith(color: Colors.black),
                    ),
                    const Gap(10),
                  ],
                );
              }
            },
          ),
          // 👇 هذا الجزء دائمًا ظاهر ومستقل عن Bloc
          const ProfileItems(),
        ],
      ),
    );
  }
}
