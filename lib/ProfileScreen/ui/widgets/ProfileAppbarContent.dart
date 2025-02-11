import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_images.dart';

class ProfileAppbarContent extends StatelessWidget {
  const ProfileAppbarContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 60),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Assets.femalepic2),
        ),
        SizedBox(height: 10),
        Text(
          "James Martin",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          "Senior Graphic Designer",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
