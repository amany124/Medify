part of 'social_cubit.dart';

@immutable
sealed class SocialState {}

final class SocialInitial extends SocialState {}

final class CreatePostCubitLoading extends SocialState {}

final class CreatePostCubitSuccess extends SocialState {}

final class CreatePostCubitError extends SocialState {
  CreatePostCubitError(this.message);
  final String message;
}

final class DeletePostLoading extends SocialState {}

final class DeletePostSuccess extends SocialState {
  final DeletePostsResponseModel deletePostsResponseModel;
  DeletePostSuccess(this.deletePostsResponseModel);
}

final class DeletePostError extends SocialState {
  DeletePostError(this.message);
  final String message;
}

final class GetPostsLoading extends SocialState {}

final class GetPostsSuccess extends SocialState {
  final GetPostsResponseModel getPostsResponseModel;

  GetPostsSuccess(this.getPostsResponseModel);
}

final class GetPostsError extends SocialState {
  final String message;

  GetPostsError(this.message);
}

final class UpdatePostLoading extends SocialState {}

final class UpdatePostSuccess extends SocialState {
  final UpdatePostResponseModel updatePostResponseModel;
  UpdatePostSuccess(this.updatePostResponseModel);
}

final class UpdatePostError extends SocialState {
  final String message;
  UpdatePostError(this.message);
}

final class SearchPostsLoading extends SocialState {}

final class SearchPostsSuccess extends SocialState {
  final List<Posts> searchResults;
  SearchPostsSuccess(this.searchResults);
}

final class SearchPostsError extends SocialState {
  final String message;
  SearchPostsError(this.message);
}

final class SearchPostsInitial extends SocialState {}

final class GetPatientSocialPostsLoading extends SocialState {}

final class GetPatientSocialPostsSuccess extends SocialState {
  final GetPostsResponseModel getPostsResponseModel;
  GetPatientSocialPostsSuccess(this.getPostsResponseModel);
}

final class GetPatientSocialPostsError extends SocialState {
  final String message;
  GetPatientSocialPostsError(this.message);
}
