import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/social/data/models/get_posts_response_model.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';
import 'package:medify/features/social/ui/widgets/post_widget.dart';

class PatientPostListView extends StatefulWidget {
  const PatientPostListView({super.key});

  @override
  State<PatientPostListView> createState() => _PatientPostListViewState();
}

class _PatientPostListViewState extends State<PatientPostListView> {
  List<Posts>? posts = [];
  List<Posts>? allPosts = []; // Store all posts for search fallback

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialCubit, SocialState>(
      builder: (context, state) {
        return switch (state) {
          SocialInitial() => _buildEmptyState(),
          GetPatientSocialPostsLoading() => _buildLoading(),
          GetPatientSocialPostsError() => _buildPatientSocialPostsError(state),
          GetPatientSocialPostsSuccess() =>
            _buildPatientSocialPostsSuccess(state),
          SearchPostsLoading() => _buildLoading(),
          SearchPostsSuccess() => _buildSearchResults(state),
          SearchPostsError() => _buildSearchError(state),
          SearchPostsInitial() => _buildInitialOrAll(),
          _ => _buildEmptyState(),
        };
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF4285F4).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.people,
              size: 64,
              color: Color(0xFF4285F4),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Welcome to Social Feed",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Connect with healthcare professionals",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialOrAll() {
    // Show all posts when search is cleared
    if (allPosts != null && allPosts!.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: allPosts!.length,
        itemBuilder: (context, index) {
          final post = allPosts![index];
          return UserPostWidget(
            postId: post.sId ?? '',
            username: post.doctorName ?? 'Unknown',
            timestamp: post.formattedDate ?? '',
            content: post.content ?? '',
            imageUrl: post.image ?? "",
            canEditDelete: false, // Patients cannot edit/delete posts
          );
        },
      );
    } else {
      return BlocBuilder<SocialCubit, SocialState>(
        builder: (context, state) {
          if (state is GetPatientSocialPostsSuccess) {
            return _buildPatientSocialPostsSuccess(state);
          } else if (state is GetPatientSocialPostsLoading) {
            return _buildLoading();
          } else if (state is GetPatientSocialPostsError) {
            return _buildPatientSocialPostsError(state);
          }
          return _buildEmptyState();
        },
      );
    }
  }

  Widget _buildPatientSocialPostsSuccess(GetPatientSocialPostsSuccess state) {
    posts = state.getPostsResponseModel.posts;
    allPosts = state.getPostsResponseModel.posts; // Store all posts

    if (posts != null && posts!.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts!.length,
        itemBuilder: (context, index) {
          final post = posts![index];
          return UserPostWidget(
            postId: post.sId ?? '',
            username: post.doctorName ?? 'Unknown',
            timestamp: post.formattedDate ?? '',
            content: post.content ?? '',
            imageUrl: post.image ?? "",
            canEditDelete: false, // Patients cannot edit/delete posts
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.post_add,
                size: 64,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No social posts yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Check back later for new content',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildPatientSocialPostsError(GetPatientSocialPostsError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Error loading social posts',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<SocialCubit>().getPatientSocialPosts(
                    token: CacheManager.getData(key: Keys.token) ?? '',
                  );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4285F4),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchPostsSuccess state) {
    final searchResults = state.searchResults;

    if (searchResults.isNotEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final post = searchResults[index];
          return UserPostWidget(
            postId: post.sId ?? '',
            username: post.doctorName ?? 'Unknown',
            timestamp: post.formattedDate ?? '',
            content: post.content ?? '',
            imageUrl: post.image ?? "",
            canEditDelete: false, // Patients cannot edit/delete posts
          );
        },
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No posts found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSearchError(SearchPostsError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Search Error',
            style: TextStyle(
              fontSize: 18,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Center _buildLoading() => Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: const Color(0xFF4285F4),
          size: 50,
        ),
      );
}
