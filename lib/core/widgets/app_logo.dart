import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medify/core/utils/app_images.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key,this.height=120,});
  final double height;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.assetsImagesAppLogo,
      height:height ,
    );
  }
}
