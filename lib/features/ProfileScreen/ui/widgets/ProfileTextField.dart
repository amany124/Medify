import 'package:flutter/material.dart';

import '../../../../core/utils/app_styles.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final bool enabled;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: const Color(0xff0E4CBD),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: label,
                labelStyle: AppStyles.semiBold14,
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
