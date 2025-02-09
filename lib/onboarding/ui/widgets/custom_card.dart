import 'package:flutter/material.dart';

class CustomCardWithShadow extends StatelessWidget {
  const CustomCardWithShadow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: Offset(5, 5),
              ),
              BoxShadow(
                color: Colors.white.withValues(alpha: 0.7),
                blurRadius: 10,
                offset: Offset(-5, -5),
              ),
            ],
            border: Border.all(
              color: Colors.red, // Border color
              width: 2, // Border width
            ),
          ),
        ),
      ),
    );
  }
}