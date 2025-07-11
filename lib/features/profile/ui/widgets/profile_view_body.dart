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
  String? name;
  String? urlImage;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = CacheManager.getData(key: Keys.role);
      final cubit = context.read<GetProfileCubit>();
      if (role == 'Doctor'  || role == 'doctor') {
        cubit.getDoctorProfile();
      } else {
        cubit.getPatientProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetProfileCubit, GetProfileState>(
      listener: (context, state) {
        if (state is GetDoctorProfileSuccess || state is GetPatientProfileSuccess ) {
          final cubit = context.read<GetProfileCubit>();
          setState(() {
            name = cubit.name;
            urlImage = cubit.urlImage;
            isLoading = false;
          });
        } else if (state is GetProfileFailure) {
          setState(() {
            errorMessage = state.failure.message;
            isLoading = false;
          });
        } else if (state is GetProfileLoading) {
          setState(() {
            isLoading = true;
            errorMessage = null;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.threeArchedCircle(
                  color: AppColors.primaryColor,
                  size: 40,
                ),
              )
            : errorMessage != null
                ? Center(
                    child: Text(
                      errorMessage!,
                      style: AppStyles.semiBold16.copyWith(color: Colors.red),
                    ),
                  )
                : Column(
                    children: [
                      Stack(
                        children: [
                          (urlImage == null || urlImage!.isEmpty)
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.blue.shade200,
                                  child: const Icon(
                                    Icons.person,
                                    size: 50,
                                    color: Colors.blue,
                                  ),
                                )
                              : ProfileImage(url: urlImage!),
                          const EditIcon(),
                        ],
                      ),
                      const Gap(8),
                      Text(
                        name ?? '',
                        style: AppStyles.semiBold16.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const Gap(10),
                      // ✅ Always visible and independent of state
                      const ProfileItems(),
                    ],
                  ),
      ),
    );
  }
}
