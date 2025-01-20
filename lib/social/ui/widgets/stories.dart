import 'package:flutter/material.dart';
import 'package:medify/chat/models/storyModel.dart';
import 'package:medify/social/ui/widgets/MyStatusStoryCard.dart';
import 'package:medify/social/ui/widgets/StoryCard.dart';

class Stories extends StatelessWidget {
  const Stories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return SizedBox(
              width: 68.5,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: MyStatusStoryCard(
                  storyData: storyModel(
                    name: 'amona',
                    image: 'assets/images/doc_test2.png',
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 60,
                child: StoryCard(
                  storyData: storyModel(
                    name: 'amona',
                    image: 'assets/images/doc_test2.png',
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
