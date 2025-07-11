import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/keys.dart';
import '../../data/models/delete_post_request_model.dart';

class PostActions extends StatelessWidget {
  final String postId;
  final VoidCallback onCommentPressed;
  final String? contentText;
  final bool canEditDelete;
  final int? likes;
  final int? commentsCount;
  final int? sharesCount;

  const PostActions({
    super.key,
    required this.onCommentPressed,
    required this.postId,
    this.contentText,
    this.canEditDelete = true,
    this.likes,
    this.commentsCount,
    this.sharesCount,
  });

  @override
  Widget build(BuildContext context) {
    final DeletePostRequestModel requestModel = DeletePostRequestModel(
      token: CacheManager.getData(key: Keys.token) ?? '',
      postId: postId,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(
          icon: Icons.favorite_border,
          activeIcon: Icons.favorite,
          count: likes ?? 0,
          isActive:
              false, // You can add logic to determine if user liked the post
          onPressed: () {
            // Handle like action
          },
          color: Colors.grey.shade600,
          activeColor: Colors.red,
        ),
        _buildActionButton(
          icon: Icons.comment_outlined,
          count: commentsCount ?? 0,
          onPressed: onCommentPressed,
          color: Colors.grey.shade600,
        ),
        _buildActionButton(
          icon: Icons.share_outlined,
          count: sharesCount ?? 0,
          onPressed: () {
            // Handle share action
          },
          color: Colors.grey.shade600,
        ),

        // Only show edit and delete buttons if canEditDelete is true
        if (canEditDelete) ...[
          _buildActionButton(
            icon: Icons.edit_outlined,
            onPressed: () {
              context.pushNamed(Routes.createPostpage, arguments: {
                'isEditing': true,
                'contentText': contentText,
                'postId': postId,
              });
            },
            color: Colors.grey.shade600,
          ),
          _buildActionButton(
            icon: Icons.delete_outline,
            onPressed: () {
              _showDeleteConfirmationDialog(context, requestModel);
            },
            color: Colors.red.shade400,
          ),
        ],
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    IconData? activeIcon,
    int? count,
    bool isActive = false,
    required VoidCallback onPressed,
    required Color color,
    Color? activeColor,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive && activeIcon != null ? activeIcon : icon,
              size: 20,
              color: isActive && activeColor != null ? activeColor : color,
            ),
            if (count != null && count > 0) ...[
              const SizedBox(width: 4),
              Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 14,
                  color: isActive && activeColor != null ? activeColor : color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DeletePostRequestModel requestModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return BlocProvider.value(
          value: BlocProvider.of<SocialCubit>(context),
          child: BlocListener<SocialCubit, SocialState>(
            listener: (context, state) {
              if (state is DeletePostSuccess) {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Post deleted successfully'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              } else if (state is DeletePostError) {
                Navigator.of(dialogContext).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(Icons.error_outline, color: Colors.white),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text('Error: ${state.message}'),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }
            },
            child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red.shade600,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Delete Post',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Are you sure you want to delete this post?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This action cannot be undone and will permanently remove the post from your profile.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                BlocBuilder<SocialCubit, SocialState>(
                  builder: (context, state) {
                    final isLoading = state is DeletePostLoading;
                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              BlocProvider.of<SocialCubit>(context)
                                  .deletepost(requestModel: requestModel);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : const Text(
                              'Delete',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
