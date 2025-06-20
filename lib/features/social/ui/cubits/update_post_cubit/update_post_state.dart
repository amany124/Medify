

part of 'update_post_cubit.dart';


@immutable
sealed class UpdatePostState {}

final class UpdatePostInitial extends UpdatePostState {}
final class UpdatePostLoading extends UpdatePostState {}
final class UpdatePostSuccess extends UpdatePostState {
  final UpdatePostResponseModel updatePostResponseModel;
 UpdatePostSuccess(this.updatePostResponseModel);
}
final class UpdatePostError extends UpdatePostState {
  final String message;
  UpdatePostError(this.message);
}
