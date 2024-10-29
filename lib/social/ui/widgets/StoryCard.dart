
import 'package:flutter/cupertino.dart';
import 'package:medify/chat/models/storyModel.dart';
import 'package:medify/core/utils/widgets/avatar.dart';

class StoryCard extends StatelessWidget {
  StoryCard({
    Key? key,
    required this.storyData,
  }) : super(key: key);

  storyModel storyData;

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