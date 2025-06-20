sealed class CreatePostCubitState {}

class CreatePostCubitInitial extends CreatePostCubitState {}

class CreatePostCubitLoading extends CreatePostCubitState {}

class CreatePostCubitSuccess extends CreatePostCubitState {}

class CreatePostCubitError extends CreatePostCubitState {
  CreatePostCubitError(this.message);
  final String message;
}
