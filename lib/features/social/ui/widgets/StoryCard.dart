import 'package:flutter/material.dart';
import 'package:medify/core/widgets/avatar.dart';

import '../../models/story_model.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.storyData,
  });

  final storyModel storyData;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Avatar.medium(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              storyData.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color.fromARGB(248, 255, 255, 255),
                fontSize: 11,
                letterSpacing: 0.3,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
