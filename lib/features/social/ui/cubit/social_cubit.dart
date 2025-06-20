import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

  Future<void> getAllPosts({
    required GetPostsRequestModel requestModel,
  }) async {
    emit(GetPostsLoading());
    final result = await socialRepo.getAllPosts(requestModel: requestModel);
    result.fold(
      (failure) {
        emit(GetPostsError(failure.message));
      },
      (response) {
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
}
