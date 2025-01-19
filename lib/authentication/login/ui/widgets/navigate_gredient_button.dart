import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final void Function()? onpressed;
  const GradientButton({super.key, this.onpressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.0, // Set the width of the button
      height: 58.0, // Set the height of the button
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Inter', // Optional: Add font family if needed
              ),
            ),
            SizedBox(width: 10.0), // Space between text and icon
            Icon(Icons.arrow_forward, size: 20.0),
          ],
        ),
      ),
    );
  }
}
