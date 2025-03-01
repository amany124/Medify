import 'package:flutter/material.dart';

class IntroWhiteCard extends StatelessWidget {
  const IntroWhiteCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 300,
        width: 239,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(20),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              
               color: Colors.black.withOpacity(0.50),
              offset: const Offset(0, 10),
              blurRadius: 20,
            ),
          ],
        ),
      ),
    );
  }
}