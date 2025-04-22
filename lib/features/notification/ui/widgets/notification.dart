import 'package:flutter/material.dart';
//import 'package:graduation_project/features/notification/ui/widgets/notification_icon.dart';

import 'notification_icon.dart';

class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final String iconPath;

  const NotificationTile({super.key, 
    required this.title,
    required this.subtitle,
    required this.time, required this.iconPath, 
    //required this.icon,
    //required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          NotificationIcon(iconPath:iconPath),
          //Icon(icon, color: Colors.blue, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize:20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}