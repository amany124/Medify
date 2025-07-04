import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/doctors/data/models/review_model.dart';

import '../../../../core/constant/endpoints.dart';
import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

abstract class ReviewRepo {
  Future<Either<Failure, List<ReviewModel>>> getDoctorReviews(String doctorId);

  Future<Either<Failure, ReviewModel>> createReview({
    required String doctorId,
    required double rating,
    required String comment,
  });

  Future<Either<Failure, ReviewModel>> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
  });

  Future<Either<Failure, bool>> deleteReview(String reviewId);
}

class ReviewRepoImpl implements ReviewRepo {
  final ApiServices apiServices;

  ReviewRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, ReviewModel>> createReview({
    required String doctorId,
    required double rating,
    required String comment,
  }) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: '${Endpoints.doctorReviews}/$doctorId',
        data: {
          'rating': rating,
          'comment': comment,
        },
        token: CacheManager.getData(key: Keys.token),
      );

      return Right(ReviewModel.fromJson(response.data['review']));
    } on DioException catch (e) {
      log('Error fetching doctor reviews: $e');

      return Left(
          Failure(e.response?.data['message'] ?? 'Failed to create review'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ReviewModel>>> getDoctorReviews(
      String doctorId) async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: '${Endpoints.doctorReviews}/$doctorId',
        token: CacheManager.getData(key: Keys.token),
      );

      final List<ReviewModel> reviews = (response.data as List)
          .map((review) => ReviewModel.fromJson(review))
          .toList();

      return Right(reviews);
    } on DioException catch (e) {
      log('Error fetching doctor reviews: ${e.response?.data}');
      return Left(Failure(
          e.response?.data['message'] ?? 'Failed to get doctor reviews'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReviewModel>> updateReview({
    required String reviewId,
    required double rating,
    required String comment,
  }) async {
    try {
      final Response response = await apiServices.putRequest(
        endpoint: '${Endpoints.doctorReviews}/$reviewId',
        data: {
          'rating': rating,
          'comment': comment,
        },
        token: CacheManager.getData(key: Keys.token),
      );

      return Right(ReviewModel.fromJson(response.data));
    } on DioException catch (e) {
      return Left(
          Failure(e.response?.data['message'] ?? 'Failed to update review'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteReview(String reviewId) async {
    try {
      await apiServices.deleteRequest(
        endpoint: '/api/reviews/$reviewId',
        token: CacheManager.getData(key: Keys.token),
      );

      return const Right(true);
    } on DioException catch (e) {
      return Left(
          Failure(e.response?.data['message'] ?? 'Failed to delete review'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
