part of 'review_cubit.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewsLoading extends ReviewState {}

class ReviewsLoaded extends ReviewState {
  final List<ReviewModel> reviews;

  const ReviewsLoaded({required this.reviews});

  @override
  List<Object> get props => [reviews];
}

class ReviewError extends ReviewState {
  final String message;

  const ReviewError({required this.message});

  @override
  List<Object> get props => [message];
}

class ReviewSubmitting extends ReviewState {}

class ReviewSubmitSuccess extends ReviewState {
  final ReviewModel review;

  const ReviewSubmitSuccess({required this.review});

  @override
  List<Object> get props => [review];
}

class ReviewUpdateSuccess extends ReviewState {
  final ReviewModel review;

  const ReviewUpdateSuccess({required this.review});

  @override
  List<Object> get props => [review];
}

class ReviewActionLoading extends ReviewState {}

class ReviewActionSuccess extends ReviewState {
  final String message;

  const ReviewActionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
