import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/widgets/bottom_navigation_content.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../data/models/get_posts_request_model.dart';
import '../widgets/post_list_view.dart';

class SocialView extends StatelessWidget {
  const SocialView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SocialCubit, SocialState>(
          listener: (context, state) {
            if (state is CreatePostCubitSuccess) {
              context.read<SocialCubit>().getAllPosts(
                    requestModel: GetPostsRequestModel(
                      doctorId:
                          LocalData.getAuthResponseModel()!.user.id.toString(),
                      token: LocalData.getAuthResponseModel()!.token,
                    ),
                  );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Text(
                'Medify',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xff223A6A),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              Gap(20),
              Expanded(child: SearchBarWidget()),
              //         CircleAvatar(
              //   radius: 20,
              //   backgroundImage: AssetImage('assets/images/female pic1.jpg'),
              // ),
            ],
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: const PostListView(),
        bottomNavigationBar: const BottomnavigationContent(),
        floatingActionButton: FloatingActionButton(
          heroTag: 'createpost',
          backgroundColor: Colors.white,
          onPressed: () {
            context.pushNamed(Routes.createPostpage, arguments: {
              'isEditing': false,
            });
          },
          child: const Icon(
            CupertinoIcons.add,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

// ...existing code...
// import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.black54),
        ),
      ),
    );
  }
}
