import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
<<<<<<< HEAD
import 'package:medify/core/routing/extensions.dart';
=======
//import 'package:graduation_project/features/profile/ui/widgets/doctor_cards.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_image.dart';
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03

import '../../../../core/utils/app_styles.dart';
import 'doctor_cards.dart';
import 'profile_image.dart';

class AppointmentsViewBody extends StatelessWidget {
  const AppointmentsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: CustomScrollView(
          clipBehavior: Clip.none,
          slivers: [
<<<<<<< HEAD
            SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  Text(
                    'My Appointments',
                    style: AppStyles.bold20.copyWith(
                      // color: AppColors.blueColor,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  const ProfileImage(
                    radius: 30,
                  ),
=======
            const SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ProfileImage(
                    radius: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // Text(
                  //   'Hello Rahma !',
                  //   style: AppStyles.bold20.copyWith(
                  //     // color: AppColors.blueColor,
                  //     color: Colors.black38,
                  //   ),
                  // )
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
                ],
              ),
            ),
            const SliverToBoxAdapter(
<<<<<<< HEAD
=======
              child: Gap(10),
            ),
            // const SliverToBoxAdapter(
            //   child: Gap(20),
            // ),
            SliverToBoxAdapter(
              child: Text(
                'My Appointments',
                style: AppStyles.bold20.copyWith(
                  // color: AppColors.blueColor,
                  color: Colors.black,
                ),
              textAlign: TextAlign.center,
               ),
            ),
            const SliverToBoxAdapter(
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
              child: Gap(30),
            ),
            const DoctorCards(),
          ],
        ),
      ),
    );
  }
}
