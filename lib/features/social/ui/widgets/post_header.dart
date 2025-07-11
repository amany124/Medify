import 'package:flutter/material.dart';

import '../../../../core/utils/app_images.dart';

class PostHeader extends StatelessWidget {
  final String username;
  final String timestamp;
  final String? profilePictureUrl;

  const PostHeader({
    super.key,
    required this.username,
    required this.timestamp,
    this.profilePictureUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Picture
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundImage:
                profilePictureUrl != null && profilePictureUrl!.isNotEmpty
                    ? NetworkImage(profilePictureUrl!) as ImageProvider
                    : const AssetImage(Assets.femalepic1),
            backgroundColor: Colors.grey.shade200,
            onBackgroundImageError: (exception, stackTrace) {
              // Handle image loading error
            },
            child: profilePictureUrl == null || profilePictureUrl!.isEmpty
                ? null
                : null,
          ),
        ),
        const SizedBox(width: 12),

        // User Info
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Verified badge (you can add logic to show this based on user status)
                  const SizedBox(width: 4),
                  Icon(
                    Icons.verified,
                    size: 16,
                    color: Colors.blue.shade600,
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                timestamp,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),

        // More options button
        // IconButton(
        //   icon: Icon(
        //     Icons.more_vert,
        //     color: Colors.grey.shade600,
        //   ),
        //   onPressed: () {
        //     // Show more options menu
        //   },
        //   padding: EdgeInsets.zero,
        //   constraints: const BoxConstraints(
        //     minWidth: 32,
        //     minHeight: 32,
        //   ),
        // ),
      ],
    );
  }
}
