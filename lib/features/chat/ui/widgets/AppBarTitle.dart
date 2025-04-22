
import 'package:flutter/material.dart';
import 'package:medify/core/widgets/avatar.dart';
import 'package:medify/features/chat/models/messageModel.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.messageData,
  });

  final messageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Avatar.small(),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageData.senderName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, fontFamily: 'poppins'),
              ),
              const SizedBox(height: 2),
              const Text(
                'Online now',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
