import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:medify/core/theme/app_colors.dart';
=======
<<<<<<< HEAD
import 'package:medify/core/theme/app_colors.dart';
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import 'package:medify/core/widgets/app_logo.dart';

void showCustomSnackBar(text, BuildContext context, {bool isError = false}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isError
                ? Colors.red.shade700
<<<<<<< HEAD
                : AppColors.secondaryColor.withValues(alpha: 0.8), // SnackBar background color
=======
<<<<<<< HEAD
                : AppColors.secondaryColor.withValues(alpha: 0.8), // SnackBar background color
=======
                : Colors.green.shade600, // SnackBar background color
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              const SizedBox(width: 20), // Space for the logo
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
        ),
        // App Logo
        const Positioned(
          top: -10, // Position the logo above the SnackBar
          left: 10,
          child: AppLogo(height: 30),
        ),
      ],
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
