import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/widgets/app_logo.dart';
import 'package:medify/core/utils/widgets/app_name.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        AppLogo(hight: 54),
        Gap(7),
        AppName(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.normal,

        ),
      ],
    );
  }
}
