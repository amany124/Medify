import 'package:flutter/material.dart';

class DoctorImage extends StatelessWidget {
  const DoctorImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        //alignment: Alignment.center,
        children: [
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue[300],
            ),
          ),
          Positioned(
            right: 3,
            //top: 90,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue[500],
              ),
            ),
          ),
          Positioned(
            child: Image.asset(
              'assets/images/doctor.png',
              height: 300,
              width: 300,
            ),
          ),
        ],
      ),
    );
  }
}
