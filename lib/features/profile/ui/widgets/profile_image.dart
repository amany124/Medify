import 'package:flutter/material.dart';
//import 'package:graduation_project/core/utils/app_images.dart';

import '../../../../core/utils/app_images.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.radius = 53,
  });
  final double radius;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: const AssetImage(
        Assets.femalepic1,
      ),
    );
  }
}
