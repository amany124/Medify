
import 'package:flutter/material.dart';

class CustomIconWithText extends StatelessWidget {
  final IconData icon;
  final num count;
  final Color? splashColor;
  final VoidCallback? onPressed;

  const CustomIconWithText({
    super.key,
    required this.icon,
    required this.count,
    this.splashColor = Colors.grey, // Default splash color.
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: Colors.transparent, // Transparent background for material.
          child: IconButton(
            splashRadius: 24,
            splashColor:
                splashColor!.withOpacity(0.3), // Customize splash color.
            icon: Icon(icon),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(width: 5),
        Text("$count"), // Display the count.
      ],
    );
  }
}
