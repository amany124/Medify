
import 'package:flutter/material.dart';
import 'package:medify/social/ui/widgets/custom_icon_with_text.dart';

class PostActions extends StatelessWidget {
  final VoidCallback onCommentPressed;

  const PostActions({super.key, required this.onCommentPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconWithText(
          icon: Icons.favorite_border,
          count: 600,
          onPressed: () {},
        ),
        CustomIconWithText(
          icon: Icons.chat_bubble_outline,
          count: 20,
          onPressed: onCommentPressed,
        ),
        CustomIconWithText(
          icon: Icons.share_outlined,
          count: 32,
          onPressed: () {},
        ),
      ],
    );
  }
}