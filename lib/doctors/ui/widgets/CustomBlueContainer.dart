import 'package:flutter/material.dart';

class CustomBlueContainer extends StatelessWidget {
  const CustomBlueContainer({
    super.key,
    required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 8, 98, 216),
              const Color(0xff1877F2),
              const Color(0xff1877F2).withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: child,
      ),
    );
  }
}
