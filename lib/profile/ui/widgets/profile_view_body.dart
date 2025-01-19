import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/utils/app_styles.dart';
import 'edit_icon.dart';
import 'profile_image.dart';
import 'profile_items.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';
//import 'package:graduation_project/features/profile/ui/widgets/edit_icon.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_image.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_items.dart';

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
          Text(
            'Rahma Ahmed',
            style: AppStyles.semiBold16.copyWith(
              // color: AppColors.blueColor,
              color: Colors.black,
            ),
          ),
          const Gap(10),
          const ProfileItems()
        ],
      ),
    );
  }
}
