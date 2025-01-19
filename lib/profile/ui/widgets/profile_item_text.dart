import 'package:flutter/material.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';

import '../../../core/utils/app_styles.dart';

class ProfileItemText extends StatelessWidget {
  const ProfileItemText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyles.semiBold16.copyWith(
        color: Colors.black,
      ),
    );
  }
}
