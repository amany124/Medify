import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/widgets/custom_icon_with_text.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/keys.dart';
import '../../data/models/delete_post_request_model.dart';

class PostActions extends StatelessWidget {
  final String postId;
  final VoidCallback onCommentPressed;
  final String? contentText;
  final bool canEditDelete; // New parameter to control edit/delete visibility

  const PostActions({
    super.key,
    required this.onCommentPressed,
    required this.postId,
    this.contentText,
    this.canEditDelete = true, // Default to true for backward compatibility
  });

  @override
  Widget build(BuildContext context) {
    final DeletePostRequestModel requestModel = DeletePostRequestModel(
      token: CacheManager.getData(key: Keys.token) ?? '',
      postId: postId,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomIconWithText(
          icon: Icons.favorite_border,
          count: 600,
          onPressed: () {},
        ),
        CustomIconWithText(
          icon: Icons.comment_outlined,
          count: 20,
          onPressed: onCommentPressed,
        ),
        CustomIconWithText(
          icon: Icons.share_outlined,
          count: 32,
          onPressed: () {},
        ),
        // Only show edit and delete buttons if canEditDelete is true
        if (canEditDelete) ...[
          CustomIconWithText(
            icon: Icons.edit,
            onPressed: () {
              context.pushNamed(Routes.createPostpage, arguments: {
                'isEditing': true,
                'contentText': contentText,
                'postId': postId,
              });
            },
          ),
          CustomIconWithText(
            icon: Icons.delete,
            onPressed: () {
              _showDeleteConfirmationDialog(context, requestModel);
            },
          ),
        ],
      ],
    );
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DeletePostRequestModel requestModel) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Delete Post',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this post? This action cannot be undone.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                BlocProvider.of<SocialCubit>(context)
                    .deletepost(requestModel: requestModel);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        );
      },
    );
  }
}
