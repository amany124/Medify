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
    if (!isClosed) emit(CreatePostCubitLoading());

    final result = await socialRepo.createPost(requestModel: requestModel);
    result.fold(
      (failure) {
        if (!isClosed) emit(CreatePostCubitError(failure.message));
      },
      (response) {
        if (!isClosed) emit(CreatePostCubitSuccess());
      },
    );
  }

  Future<void> deletepost({
    required DeletePostRequestModel requestModel,
  }) async {
    if (!isClosed) emit(DeletePostLoading());

    final result = await socialRepo.deletePost(requestModel: requestModel);
    result.fold(
      (failure) {
        if (!isClosed) emit(DeletePostError(failure.message));
      },
      (response) async {
        if (!isClosed) emit(DeletePostSuccess(response));
        await getAllPosts(
          requestModel: GetPostsRequestModel(
            doctorId: LocalData.getAuthResponseModel()!.user.id.toString(),
            token: LocalData.getAuthResponseModel()!.token,
          ),
        );
      },
    );
  }

  List<Posts> _allPosts = [];

  void searchPosts(String query) {
    if (query.isEmpty) {
      if (!isClosed) emit(SearchPostsInitial());
      return;
    }

    if (!isClosed) emit(SearchPostsLoading());

    try {
      final searchResults = _allPosts.where((post) {
        final content = post.content?.toLowerCase() ?? '';
        final doctorName = post.doctorName?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();
        return content.contains(searchQuery) || doctorName.contains(searchQuery);
      }).toList();

      if (!isClosed) emit(SearchPostsSuccess(searchResults));
    } catch (e) {
      if (!isClosed) emit(SearchPostsError('Error searching posts: $e'));
    }
  }

  void clearSearch() {
    if (!isClosed) emit(SearchPostsInitial());
  }

  Future<void> getAllPosts({
    required GetPostsRequestModel requestModel,
  }) async {
    if (!isClosed) emit(GetPostsLoading());

    final result = await socialRepo.getAllPosts(requestModel: requestModel);
    result.fold(
      (failure) {
        if (!isClosed) emit(GetPostsError(failure.message));
      },
      (response) {
        _allPosts = response.posts ?? [];
        if (!isClosed) emit(GetPostsSuccess(response));
      },
    );
  }

  Future<void> updatePost({
    required UpdatePostsRequestModel requestModel,
  }) async {
    if (!isClosed) emit(UpdatePostLoading());

    final result = await socialRepo.updatePost(requestModel: requestModel);
    result.fold(
      (failure) {
        if (!isClosed) emit(UpdatePostError(failure.message));
      },
      (response) async {
        if (!isClosed) emit(UpdatePostSuccess(response));
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
    if (!isClosed) emit(GetPatientSocialPostsLoading());

    final result = await socialRepo.getPatientSocialPosts(token: token);
    result.fold(
      (failure) {
        if (!isClosed) emit(GetPatientSocialPostsError(failure.message));
      },
      (response) {
        _allPosts = response.posts ?? [];
        if (!isClosed) emit(GetPatientSocialPostsSuccess(response));
      },
    );
  }
}
