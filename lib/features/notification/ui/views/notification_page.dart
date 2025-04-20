import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/widgets/bottom_navigation_content.dart';

import '../../../../core/utils/app_images.dart';
import '../widgets/notification.dart';
import '../widgets/section_title.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomnavigationContent(),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,

      //   elevation: 0,
      //   title: Text(
      //     'Notifications',
      //     style: AppStyles.bold22.copyWith(
      //       color: AppColors.blueColor,
      //     ),
      //   ),
      //    centerTitle: true,
      //   // leading: IconButton(
      //   //   onPressed: () {
      //   //     Navigator.pop(context);
      //   //   },
      //   //   icon: const Icon(Icons.arrow_back_ios),
      //   //   color: AppColors.blueColor,
      //   // ),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: const [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SectionTitle(title: 'Today'),
                Text(
                  'Mark all',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff2260FF),
                  ),
                ),
              ],
            ),
            Gap(15),
            NotificationTile(
              title: 'Scheduled Appointment',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '2M',
              iconPath: Assets.assetsImagesCalendar,
            ),
            NotificationTile(
              title: 'Scheduled Change',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '2H',
              iconPath: Assets.assetsImagesCalendar,
            ),
            NotificationTile(
              title: 'Medical Notes',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '3H',
              iconPath: Assets.assetsImagesNote1, //here
            ),
            Gap(15),
            SectionTitle(title: 'Yesterday'),
            Gap(15),
            NotificationTile(
              title: 'Scheduled Appointment',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '2M',
              iconPath: Assets.assetsImagesCalendar,
            ),
            Gap(15),
            SectionTitle(title: '15 April'),
            Gap(15),
            NotificationTile(
              title: 'Scheduled Appointment',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '2M',
              iconPath: Assets.assetsImagesCalendar,
            ),
            NotificationTile(
              title: 'Scheduled Appointment',
              subtitle:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
              time: '2M',
              iconPath: Assets.assetsImagesCalendar,
            ),
          ],
        ),
      ),
    );
  }
}
