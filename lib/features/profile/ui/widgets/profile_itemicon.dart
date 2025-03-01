import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
//import 'package:graduation_project/core/theme/app_colors.dart';

import '../../../../core/theme/app_colors.dart';

class ProfileItemIcon extends StatelessWidget {
  const ProfileItemIcon({
    super.key,
    required this.iconPath, 
  });
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: AppColors.iconBackColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        iconPath,
         // ignore: deprecated_member_use
         color: AppColors.blueColor,
      ),
    );
  }
}
