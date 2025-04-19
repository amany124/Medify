import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../ProfileScreen/ui/cubit/get_profile_cubit.dart';
=======
import 'package:gap/gap.dart';

import '../../../../core/utils/app_styles.dart';
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
import 'edit_icon.dart';
import 'profile_image.dart';
import 'profile_items.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({
    super.key,
  });

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
<<<<<<< HEAD
          BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
             if (state is GetPatientProfileSuccess) {
  return Text(
    state.patientModel!.name,
    style: AppStyles.semiBold16.copyWith(
      color: Colors.black,
    ),
  );
} else if (state is GetDoctorProfileSuccess) {
  return Text(
    state.doctorModel!.name,
    style: AppStyles.semiBold16.copyWith(
      color: Colors.black,
    ),
  );
} else if (state is GetProfileFailure) {
  return Text(
    state.failure.message,
    style: AppStyles.semiBold16.copyWith(
      color: Colors.black,
    ),
  );
} else {
  return Center(
    child: LoadingAnimationWidget.progressiveDots(
      color: AppColors.primaryColor,
      size: 30,
    ),
  );
}
            }
=======
          Text(
            'Rahma Ahmed',
            style: AppStyles.semiBold16.copyWith(
              // color: AppColors.blueColor,
              color: Colors.black,
            ),
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
          ),
          const Gap(10),
          const ProfileItems()
        ],
      ),
    );
  }
}
