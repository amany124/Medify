part of 'delete_post_cubit.dart';

@immutable
sealed class DeletePostState {}

final class DeletePostInitial extends DeletePostState {}

final class DeletePostLoading extends DeletePostState {}
final class DeletePostSuccess extends DeletePostState {
   DeletePostsResponseModel deletePostsResponseModel;
   DeletePostSuccess(this.deletePostsResponseModel);
}
final class DeletePostError extends DeletePostState {
   DeletePostError(this.message);
  final String message;
}
