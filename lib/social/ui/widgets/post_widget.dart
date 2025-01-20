import 'package:flutter/material.dart';
import 'package:medify/social/ui/widgets/comment_section.dart';
import 'package:medify/social/ui/widgets/post_actions.dart';
import 'package:medify/social/ui/widgets/post_header.dart';

class Post extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String imageUrl;

  const Post({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.imageUrl,
  });

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostHeader(
                username: widget.username,
                timestamp: widget.timestamp,
              ),
              const SizedBox(height: 10),
              Text(widget.content),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(widget.imageUrl),
              ),
              const SizedBox(height: 10),
              PostActions(
                onCommentPressed: () {
                  setState(() {
                    showComments = !showComments;
                  });
                },
              ),
              if (showComments) const CommentSection(),
            ],
          ),
        ),
      ),
    );
  }
}