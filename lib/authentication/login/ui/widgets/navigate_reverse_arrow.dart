import 'package:flutter/material.dart';

class ReverseArrow extends StatelessWidget {
  final VoidCallback? onPressed;

  const ReverseArrow({
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      width: 58,
      decoration: BoxDecoration(
        color: Color(0xffF3F9FF), // Light blue background color
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
        onPressed: onPressed, child: Icon(
          Icons.arrow_back,
          color: Color(0xff1677FF), // Dark blue icon color
        ),)
    );
  }
}
