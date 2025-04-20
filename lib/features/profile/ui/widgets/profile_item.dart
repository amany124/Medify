import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_item_text.dart';
//import 'package:graduation_project/features/profile/ui/widgets/profile_itemicon.dart';

import 'profile_item_text.dart';
import 'profile_itemicon.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.text,
    required this.iconPath,
    this.onTap,
  });
  final String text;
  final String iconPath;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ProfileItemIcon(
            iconPath: iconPath,
          ),
          const Gap(15),
          ProfileItemText(
            text: text,
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_forward_ios,
              color:Colors.blue,
              // AppColors.iconBackColor,
            ),
          )
        ],
      ),
    );
  }
}
