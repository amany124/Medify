import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';

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
                ],
              ),
            ),
            const SliverToBoxAdapter(
              child: Gap(30),
            ),
            const DoctorCards(),
          ],
        ),
      ),
    );
  }
}
