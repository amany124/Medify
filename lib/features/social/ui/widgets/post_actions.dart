import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/cubits/delete_post_cubit/delete_post_cubit.dart';
import 'package:medify/features/social/ui/widgets/custom_icon_with_text.dart';

import '../../../../core/helpers/local_data.dart';
import '../../../../core/routing/routes.dart';
import '../../data/models/delete_post_request_model.dart';

class PostActions extends StatelessWidget {
  final String postId;
  final VoidCallback onCommentPressed;
  final String? contentText;

  PostActions(
      {super.key, required this.onCommentPressed, required this.postId,this.contentText });

  @override
  Widget build(BuildContext context) {
    final DeletePostRequestModel requestModel = DeletePostRequestModel(
      token: LocalData.getAuthResponseModel()!.token,
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
          icon: Icons.edit,

          // count: 20,
          onPressed: () {
            context.pushNamed(Routes.createPostpage, arguments: {
              'isEditing': true,
              'contentText': contentText,
              'postId': postId,

              // 'postId': postId,
            });
          },
        ),
        CustomIconWithText(
          icon: Icons.delete,
          // count: 32,
          onPressed: () {
            BlocProvider.of<SocialCubit>(context)
                .deletepost(requestModel: requestModel);
          },
        ),
      ],
    );
  }
}
