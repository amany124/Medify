
import 'package:flutter/material.dart';
import 'package:medify/core/utils/widgets/avatar.dart';

class Comment extends StatelessWidget {
  final String username;
  final String content;
  final String timestamp;

  const Comment({
    super.key,
    required this.username,
    required this.content,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar.small(),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      timestamp,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(content),
              ],
            ),
          ),
        ],
      ),
    );
  }
}