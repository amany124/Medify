import 'package:flutter/material.dart';
//import 'package:graduation_project/core/theme/app_colors.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_view_body.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const ProfileViewBody(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'My Profile',
          style: AppStyles.semiBold16.copyWith(
            color: AppColors.blueColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blueColor,
            weight: 2,
          ),
          padding: const EdgeInsets.only(left: 30),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
