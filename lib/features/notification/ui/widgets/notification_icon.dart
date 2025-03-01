import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({super.key, required this.iconPath});
  
  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color:Color(0xff2260ff),// AppColors.iconBackColor,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        iconPath,
         // ignore: deprecated_member_use
          color:Colors.white //AppColors.blueColor,
      ),
    );
  }
}