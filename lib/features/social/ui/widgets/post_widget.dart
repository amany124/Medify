import 'package:flutter/material.dart';
import 'package:medify/features/social/ui/widgets/comment_section.dart';
import 'package:medify/features/social/ui/widgets/post_actions.dart';
import 'package:medify/features/social/ui/widgets/post_header.dart';

class UserPostWidget extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String imageUrl;
  final String postId;

  const UserPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.postId,
    this.imageUrl =
        "https://media.istockphoto.com/id/1437830105/photo/cropped-shot-of-a-female-nurse-hold-her-senior-patients-hand-giving-support-doctor-helping.jpg?s=612x612&w=0&k=20&c=oKR-00at4oXr4tY5IxzqsswaLaaPsPRkdw2MJbYHWgA=",
  });

  @override
  _UserPostWidgetState createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
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
                child: Image.network(
                  widget.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey.shade600,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Unable to load image',
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              PostActions(
                postId: widget.postId,
                contentText: widget.content,
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
