import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class GradientButton extends StatelessWidget {
  final void Function()? onpressed;
  const GradientButton({
    super.key,
    this.onpressed,
    required this.label,
    this.isloading = false,
  });
  final String label;
  final bool isloading;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0, // Set the width of the button
      height: 50.0, // Set the height of the button
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff1677FF),
            Color(0xff1677FF),
            Color.fromARGB(255, 82, 152, 251)
          ], // Blue gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(16.0), // Rounded border
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, // Keep button color transparent
          shadowColor: Colors.transparent, // Remove shadow
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Match border radius
          ),
        ),
        onPressed: onpressed,
        child: isloading
            ? LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 20,
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontFamily:
                          'Inter', // Optional: Add font family if needed
                    ),
                  ),
                  const SizedBox(width: 10.0), // Space between text and icon
                  const Icon(
                    Icons.arrow_forward,
                    size: 20.0,
                    color: Colors.white,
                  ), // Arrow icon
                ],
              ),
      ),
    );
  }
}
