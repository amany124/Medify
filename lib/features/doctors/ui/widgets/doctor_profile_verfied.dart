import 'package:flutter/material.dart';

class DoctorProfileVerfied extends StatelessWidget {
  const DoctorProfileVerfied({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xff1877F2)
            .withValues(alpha:0.1),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.verified,
        color: Color(0xff1877F2),
        size: 16,
      ),
    );
  }
}
