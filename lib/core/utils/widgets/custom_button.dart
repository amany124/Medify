import 'package:flutter/material.dart';

import '../app_styles.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
    this.borderColor,
    required this.buttonWidth,
    this.buttonHeight = 56,
    required this.onPressed,
    this.radius = 32,
    this.fontsize = 15,
  });
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;
  final double buttonWidth;
  final double buttonHeight;
  final double radius;
  final double fontsize;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: buttonHeight,
      minWidth: buttonWidth,
      color: backgroundColor, //const Color(0xff407CE2),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: borderColor != null
            ? BorderSide(color: borderColor!)
            : BorderSide.none,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: AppStyles.regular15.copyWith(
          color: textColor,
          fontSize: fontsize,
          
        ),
      ),
    );
  }
}
