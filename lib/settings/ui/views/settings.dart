import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_item_text.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_itemicon.dart';
//import 'package:graduation_project/features/settings/ui/views/password_manager.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../core/utils/app_images.dart';
import '../../../profile/ui/widgets/profile_item.dart';
import '../../../profile/ui/widgets/profile_item_text.dart';
import '../../../profile/ui/widgets/profile_itemicon.dart';
import 'password_manager.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: AppStyles.bold22.copyWith(
            color: AppColors.blueColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.blueColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
        child: Column(
          children: [
            ProfileItem(
              text: 'Manage Password',
              iconPath: Assets.assetsImagesPassword,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PasswordManager(),
                  ),
                );
              },
            ),
            const Gap(5),
            Row(
              children: [
                const ProfileItemIcon(iconPath:Assets.assetsImagesDarkMode),
               // const Icon(Icons.dark_mode),
                const Gap(15),
                const ProfileItemText(text: 'Dark Mode'),
               // const Text('Dark Mode'),
                 const Gap(185),
                Switch(
                  activeColor: Colors.blue,
                  value:true,
                 onChanged:(value){}
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
