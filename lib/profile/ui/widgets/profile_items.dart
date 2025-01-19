import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/features/about%20us/ui/views/aboutus_view.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
//import 'package:graduation_project/features/favorite_docs/ui/views/FavoriteDoctors.dart';
//import 'package:graduation_project/features/heart%20diseases/ui/views/heart_diseases.dart';
//import 'package:graduation_project/features/onboarding/ui/views/start_view.dart';
//import 'package:graduation_project/features/profile/ui/views/MyAppointments_view.dart';
//import 'package:graduation_project/features/profile/ui/views/myprofile_view.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_item.dart';
//import 'package:graduation_project/features/settings/ui/views/settings.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
//import '../../../../core/widgets/custom_button.dart';
import '../../../about us/ui/views/aboutus_view.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/widgets/custom_button.dart';
import '../../../favorite_docs/ui/views/FavoriteDoctors.dart';
import '../../../feedback/feedback_view.dart';
import '../../../heart diseases/ui/views/heart_diseases.dart';
import '../../../settings/ui/views/settings.dart';
import '../../../start_screen/ui/views/start_view.dart';
import '../views/MyAppointments_view.dart';
import 'profile_item.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({
    super.key,
  });
  static List<ProfileItem> getitems(context) => [
        const ProfileItem(
          text: 'Profile',
          iconPath: Assets.assetsImagesPerson,
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => const MyprofileView(),
          //     ),
          //   );
          // },
        ),
        // favorite doc
        ProfileItem(
          text: 'Favorite Doctors',
          iconPath: Assets.assetsImagesFavoriteDoctors,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Favoritedoctors(),
              ),
            );
          },
        ),
        // Your Appointments
        ProfileItem(
          text: 'Your Appointments',
          iconPath: Assets.assetsImagesAppointment,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppointmentsView(),
              ),
            );
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsView(),
              ),
            );
          },
        ),
        // heart diseases
        ProfileItem(
            text: 'heart diseases',
            iconPath: Assets.assetsImagesAnatomicalHeart,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HeartDiseases(),
                ),
              );
            }),

        // about us
        ProfileItem(
          text: 'about us',
          iconPath: Assets.assetsImagesInformation,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AboutusView(),
              ),
            );
          },
        ),
        //feedback
        ProfileItem(
          text: ' feedback',
          iconPath: Assets.assetsImagesFeedback,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FeedbackView(),
              ),
            );
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
