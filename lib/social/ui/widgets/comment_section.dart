


import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/social/ui/widgets/comment.dart';

class CommentSection extends StatelessWidget {
  const CommentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(thickness: 0.5),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Gap(20),
            Comment(
              username: "John Doe",
              content: "Great post!",
              timestamp: "10 min ago",
            ),
            Gap(15),
            Comment(
              username: "Sarah Smith",
              content: "I love this message!",
              timestamp: "1 hour ago",
            ),
            Gap(15),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Write a comment...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ],
        ),
      ],
    );
  }
}