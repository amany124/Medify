import 'package:flutter/material.dart';
//import 'package:graduation_project/core/theme/app_colors.dart';

import '../../../../core/theme/app_colors.dart';

class EditIcon extends StatelessWidget {
  const EditIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned(
      bottom: 0,
      right: 0,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: AppColors.blueColor,
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
