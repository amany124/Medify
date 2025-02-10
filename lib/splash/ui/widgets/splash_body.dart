import 'package:flutter/material.dart';

import '../../../core/utils/app_images.dart';
import 'splash_container.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            Assets.assetsImagesSplashBackground,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color(0xff577CEF).withValues(alpha: 0.3),
            ),
          ),
          SplashContainerChild(),
        ],
      ),
    );
  }
}
