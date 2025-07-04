import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/doctors/data/models/review_model.dart';
import 'package:medify/features/doctors/data/repos/review_repo.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewRepo _reviewRepo;

  ReviewCubit({
    required ReviewRepo reviewRepo,
  })  : _reviewRepo = reviewRepo,
        super(ReviewInitial());

  Future<void> getDoctorReviews(String doctorId) async {
    emit(ReviewsLoading());

    final result = await _reviewRepo.getDoctorReviews(doctorId);

    result.fold(
      (failure) => emit(ReviewError(message: failure.message)),
      (reviews) => emit(ReviewsLoaded(reviews: reviews)),
    );
  }

  Future<void> createReview({
    required String doctorId,
    required double rating,
    required String comment,
  }) async {
    emit(ReviewSubmitting());

    final result = await _reviewRepo.createReview(
      doctorId: doctorId,
      rating: rating,
      comment: comment,
    );

    result.fold(
      (failure) => emit(ReviewError(message: failure.message)),
      (review) => emit(ReviewSubmitSuccess(review: review)),
    );
  }

  Future<void> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
  }) async {
    emit(ReviewSubmitting());

    final result = await _reviewRepo.updateReview(
      reviewId: reviewId,
      rating: rating,
      comment: comment,
    );

    result.fold(
      (failure) => emit(ReviewError(message: failure.message)),
      (review) => emit(ReviewUpdateSuccess(review: review)),
    );
  }

  Future<void> deleteReview(String reviewId) async {
    emit(ReviewActionLoading());

    final result = await _reviewRepo.deleteReview(reviewId);

    result.fold(
      (failure) => emit(ReviewError(message: failure.message)),
      (_) => emit(
          const ReviewActionSuccess(message: 'Review deleted successfully')),
    );
  }
}
