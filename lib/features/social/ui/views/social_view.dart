import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../../../core/utils/keys.dart';
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
                      doctorId: CacheManager.getData(key: Keys.userId) ?? '',
                      token: CacheManager.getData(key: Keys.token) ?? '',
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

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (value.isEmpty) {
        context.read<SocialCubit>().clearSearch();
      } else {
        context.read<SocialCubit>().searchPosts(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _searchController,
        textAlign: TextAlign.center,
        onChanged: (value) {
          setState(() {}); // Trigger rebuild to update suffix icon
          _onSearchChanged(value);
        },
        decoration: InputDecoration(
          hintText: 'Search posts...',
          hintStyle: const TextStyle(color: Colors.black54),
          border: InputBorder.none,
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                    context.read<SocialCubit>().clearSearch();
                  },
                )
              : const Icon(Icons.search, color: Colors.black54),
        ),
      ),
    );
  }
}
