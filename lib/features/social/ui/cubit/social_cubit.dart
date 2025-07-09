import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/local_data.dart';
import '../../data/models/create_post_request_model.dart';
import '../../data/models/delete_post_request_model.dart';
import '../../data/models/delete_post_response_model.dart';
import '../../data/models/get_posts_request_model.dart';
import '../../data/models/get_posts_response_model.dart';
import '../../data/models/update_post_request_model.dart';
import '../../data/models/update_post_response_model.dart';
import '../../data/repos/social_repo.dart';

part 'social_state.dart';

class SocialCubit extends Cubit<SocialState> {
  final SocialRepo socialRepo;
  SocialCubit(this.socialRepo) : super(SocialInitial());

  Future<void> createPost({
    required CreatePostRequestModel requestModel,
  }) async {
    emit(CreatePostCubitLoading());
    final result = await socialRepo.createPost(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(CreatePostCubitError(failure.message));
      },
      (response) {
        print('object');
        emit(CreatePostCubitSuccess());
      },
    );
  }

  Future<void> deletepost({
    required DeletePostRequestModel requestModel,
  }) async {
    emit(DeletePostLoading());
    final result = await socialRepo.deletePost(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(DeletePostError(failure.message));
      },
      (response) async {
        emit(DeletePostSuccess(response));
        await getAllPosts(
          requestModel: GetPostsRequestModel(
            doctorId: LocalData.getAuthResponseModel()!.user.id.toString(),
            token: LocalData.getAuthResponseModel()!.token,
          ),
        );
      },
    );
  }

  // Store all posts for search functionality
  List<Posts> _allPosts = [];

  void searchPosts(String query) {
    if (query.isEmpty) {
      emit(SearchPostsInitial());
      return;
    }

    emit(SearchPostsLoading());

    try {
      final searchResults = _allPosts.where((post) {
        final content = post.content?.toLowerCase() ?? '';
        final doctorName = post.doctorName?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        return content.contains(searchQuery) ||
            doctorName.contains(searchQuery);
      }).toList();

      emit(SearchPostsSuccess(searchResults));
    } catch (e) {
      emit(SearchPostsError('Error searching posts: $e'));
    }
  }

  void clearSearch() {
    // When clearing search, emit the last successful posts state if available
    if (_allPosts.isNotEmpty) {
      emit(SearchPostsInitial());
    } else {
      emit(SearchPostsInitial());
    }
  }

  Future<void> getAllPosts({
    required GetPostsRequestModel requestModel,
  }) async {
    emit(GetPostsLoading());
    final result = await socialRepo.getAllPosts(requestModel: requestModel);
    result.fold(
      (failure) {
        print('Error fetching posts: ${failure.message}');
        emit(GetPostsError(failure.message));
      },
      (response) {
        // Store all posts for search functionality
        _allPosts = response.posts ?? [];
        emit(GetPostsSuccess(response));
      },
    );
  }

  Future<void> updatePost({
    required UpdatePostsRequestModel requestModel,
  }) async {
    emit(UpdatePostLoading());
    final result = await socialRepo.updatePost(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(UpdatePostError(failure.message));
      },
      (response) async {
        emit(UpdatePostSuccess(response));
        await getAllPosts(
          requestModel: GetPostsRequestModel(
            doctorId: LocalData.getAuthResponseModel()!.user.id.toString(),
            token: LocalData.getAuthResponseModel()!.token,
          ),
        );
      },
    );
  }

  Future<void> getPatientSocialPosts({
    required String token,
  }) async {
    emit(GetPatientSocialPostsLoading());
    final result = await socialRepo.getPatientSocialPosts(token: token);
    result.fold(
      (failure) {
        print('Error fetching patient social posts: ${failure.message}');
        emit(GetPatientSocialPostsError(failure.message));
      },
      (response) {
        // Store all posts for search functionality
        _allPosts = response.posts ?? [];
        emit(GetPatientSocialPostsSuccess(response));
      },
    );
  }
}
