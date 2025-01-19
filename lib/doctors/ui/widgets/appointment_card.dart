import 'package:flutter/material.dart';
//import 'package:graduation_project/core/utils/app_images.dart';

import '../../../core/utils/app_images.dart';

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Row(
          children: [
            // Doctor Image
            CircleAvatar(
              radius: 30,
              backgroundImage:AssetImage(Assets.assetsImagesDoctor),
            ),
            SizedBox(width: 15),
            // Doctor Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Appointment cancelled",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Wed, 17 May | 08.30 AM",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Dr. Randy Wigham",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "General Medical Checkup",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: 16),
                      SizedBox(width: 5),
                      Text(
                        "4.8 ",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // More Options
            //Icon(Icons.more_vert, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}