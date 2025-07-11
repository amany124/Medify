import 'package:flutter/material.dart';
import 'package:medify/features/social/ui/widgets/comment_section.dart';
import 'package:medify/features/social/ui/widgets/post_actions.dart';
import 'package:medify/features/social/ui/widgets/post_header.dart';

class UserPostWidget extends StatefulWidget {
  final String username;
  final String timestamp;
  final String content;
  final String? imageUrl;
  final String postId;
  final bool canEditDelete;
  final String? profilePictureUrl;
  final int? likes;
  final int? commentsCount;
  final int? sharesCount;

  const UserPostWidget({
    super.key,
    required this.username,
    required this.timestamp,
    required this.content,
    required this.postId,
    this.imageUrl,
    this.canEditDelete = true,
    this.profilePictureUrl,
    this.likes,
    this.commentsCount,
    this.sharesCount,
  });

  @override
  _UserPostWidgetState createState() => _UserPostWidgetState();
}

class _UserPostWidgetState extends State<UserPostWidget> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: PostHeader(
                username: widget.username,
                timestamp: widget.timestamp,
                profilePictureUrl: widget.profilePictureUrl,
              ),
            ),

            // Post Content
            if (widget.content.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  widget.content,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
              ),

            // Post Image (if exists)
            if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.imageUrl!,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: const Color(0xFF4285F4),
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Loading image...',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image_outlined,
                              size: 48,
                              color: Colors.grey.shade500,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Unable to load image',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tap to retry',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

            // // Engagement Stats (likes, comments, shares)
            // if (widget.likes != null ||
            //     widget.commentsCount != null ||
            //     widget.sharesCount != null)
            //   Padding(
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         if (widget.likes != null && widget.likes! > 0)
            //           Row(
            //             children: [
            //               const Icon(
            //                 Icons.favorite,
            //                 color: Colors.red,
            //                 size: 16,
            //               ),
            //               const SizedBox(width: 4),
            //               Text(
            //                 '${widget.likes}',
            //                 style: TextStyle(
            //                   color: Colors.grey.shade600,
            //                   fontSize: 14,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         const Spacer(),
            //         Row(
            //           children: [
            //             if (widget.commentsCount != null &&
            //                 widget.commentsCount! > 0) ...[
            //               Text(
            //                 '${widget.commentsCount} comments',
            //                 style: TextStyle(
            //                   color: Colors.grey.shade600,
            //                   fontSize: 14,
            //                 ),
            //               ),
            //               const SizedBox(width: 12),
            //             ],
            //             if (widget.sharesCount != null &&
            //                 widget.sharesCount! > 0)
            //               Text(
            //                 '${widget.sharesCount} shares',
            //                 style: TextStyle(
            //                   color: Colors.grey.shade600,
            //                   fontSize: 14,
            //                 ),
            //               ),
            //           ],
            //         ),
            //       ],
            //     ),
            //   ),

            // Divider
            if (widget.likes != null ||
                widget.commentsCount != null ||
                widget.sharesCount != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: Colors.grey.shade200,
                  thickness: 1,
                ),
              ),

            // Post Actions
            Padding(
              padding: const EdgeInsets.all(5),
              child: PostActions(
                postId: widget.postId,
                contentText: widget.content,
                canEditDelete: widget.canEditDelete,
                likes: widget.likes,
                commentsCount: widget.commentsCount,
                sharesCount: widget.sharesCount,
                onCommentPressed: () {
                  setState(() {
                    showComments = !showComments;
                  });
                },
              ),
            ),

            // Comments Section
            if (showComments)
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: CommentSection(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
