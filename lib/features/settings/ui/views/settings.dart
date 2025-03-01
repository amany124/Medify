import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/app_images.dart';
import '../../../profile/ui/widgets/profile_item.dart';
import '../../../profile/ui/widgets/profile_item_text.dart';
import '../../../profile/ui/widgets/profile_itemicon.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
                context.pushNamed(Routes.passwordManager);
              },
            ),
            const Gap(5),
            Row(
              children: [
                const ProfileItemIcon(iconPath: Assets.assetsImagesDarkMode),
                // const Icon(Icons.dark_mode),
                const Gap(15),
                const ProfileItemText(text: 'Dark Mode'),
                // const Text('Dark Mode'),
                const Gap(185),
                Switch(
                    activeColor: Colors.blue,
                    value: true,
                    onChanged: (value) {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
