import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../onboarding/ui/views/start_view.dart';
import 'profile_item.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
  });
  static List<ProfileItem> getitems(BuildContext context) => [
        ProfileItem(
          text: 'Profile',
          iconPath: Assets.assetsImagesPerson,
          onTap: () {
            context.pushNamed(Routes.privateProfile);
          },
        ),
        // favorite doc
        ProfileItem(
          text: 'Favorite Doctors',
          iconPath: Assets.assetsImagesFavoriteDoctors,
          onTap: () {
            context.pushNamed(Routes.favoritedoctors);
          },
        ),
        // Your Appointments
        ProfileItem(
          text: 'Your Appointments',
          iconPath: Assets.assetsImagesAppointment,
          onTap: () {
            context.pushNamed(Routes.myAppointments);
          },
        ),
        // history
        const ProfileItem(
          text: 'History',
          iconPath: Assets.assetsImagesHistory,
        ),
        // settings
        ProfileItem(
          text: 'Settings',
          iconPath: Assets.assetsImagesSetting,
          onTap: () {
            context.pushNamed(Routes.settingsScreen);
          },
        ),
        // heart diseases
        ProfileItem(
            text: 'heart diseases',
            iconPath: Assets.assetsImagesAnatomicalHeart,
            onTap: () {
              context.pushNamed(Routes.heartDiseases);
            }),

        // about us
        ProfileItem(
          text: 'about us',
          iconPath: Assets.assetsImagesInformation,
          onTap: () {
            context.pushNamed(Routes.aboutUs);
          },
        ),
        //feedback
        ProfileItem(
          text: ' feedback',
          iconPath: Assets.assetsImagesFeedback,
          onTap: () {
            context.pushNamed(Routes.feedbackScreen);
          },
        ),
        // visit website
        const ProfileItem(
          text: 'visit website',
          iconPath: Assets.assetsImagesGlobe,
        ),

        //logout
        ProfileItem(
          text: 'Logout',
          iconPath: Assets.assetsImagesLogout,
          onTap: () {
            // dialog
            showDialog(
              context: context,
              builder: (context) => Dialog(
                insetPadding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 0.0),
                alignment: Alignment.bottomCenter,
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Logout',
                        style: AppStyles.bold22.copyWith(
                          color: AppColors.blueColor,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Are you sure you want to logout?',
                        style: AppStyles.semiBold14.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                            text: 'Cancel',
                            buttonHeight: 40,
                            textColor: AppColors.secondaryColor,
                            backgroundColor: const Color(0xffCAD6FF),
                            buttonWidth: 124,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Gap(30),
                          CustomButton(
                            text: 'Yes , Logout',
                            buttonHeight: 40,
                            textColor: Colors.white,
                            backgroundColor: const Color(0xff2260FF),
                            buttonWidth: 124,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StartView(),
                                ),
                              );
                              // Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: getitems(context),
    );
  }
}
//about us
//heart diseases
//feedback 
// visit website 
