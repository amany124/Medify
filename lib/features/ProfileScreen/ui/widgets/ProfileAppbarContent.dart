import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_images.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

class ProfileAppbarContent extends StatelessWidget {
  const ProfileAppbarContent({
    super.key,
    required this.name,
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        const CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Assets.femalepic2),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          CacheManager.getData(key: Keys.role),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
