import 'package:flutter/material.dart';
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
                : Colors.green.shade600, // SnackBar background color
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
