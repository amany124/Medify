import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/social/data/models/create_post_request_model.dart';
import 'package:medify/features/social/data/models/create_post_response_model.dart';
import 'package:medify/features/social/data/models/delete_post_request_model.dart';
import 'package:medify/features/social/data/models/delete_post_response_model.dart';
import 'package:medify/features/social/data/models/get_posts_request_model.dart';
import 'package:medify/features/social/data/models/get_posts_response_model.dart';
import 'package:medify/features/social/data/models/update_post_request_model.dart';
import 'package:medify/features/social/data/models/update_post_response_model.dart';

import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/services/api_service.dart';

abstract class SocialRepo {
  // Add your repository methods here
  Future<Either<Failure, CreatePostResponseModel>> createPost({
    required CreatePostRequestModel requestModel,
  });

  Future<Either<Failure, UpdatePostResponseModel>> updatePost({
    required UpdatePostsRequestModel requestModel,
  });

  Future<Either<Failure, DeletePostsResponseModel>> deletePost({
    required DeletePostRequestModel requestModel,
  });

  Future<Either<Failure, GetPostsResponseModel>> getAllPosts({
    required GetPostsRequestModel requestModel,
  });

  Future<Either<Failure, GetPostsResponseModel>> getPatientSocialPosts({
    required String token,
  });
}

class SocialRepoImpl implements SocialRepo {
  final ApiServices apiServices;
  SocialRepoImpl({
    required this.apiServices,
  });

  @override
  Future<Either<Failure, CreatePostResponseModel>> createPost({
    required CreatePostRequestModel requestModel,
  }) async {
    try {
      // send request to the server
      final response = await apiServices.postRequest(
        endpoint: Endpoints.createPost,
        token: requestModel.token,
        contentType: ContentType.multipart,
        data: await requestModel.toJson(),
      );
      // map response to the model
      final responseModel = CreatePostResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetPostsResponseModel>> getAllPosts({
    required GetPostsRequestModel requestModel,
  }) async {
    try {
      print('*' * 30);
      print(CacheManager.getData(key: Keys.userId) ?? '');
      // send request to the server
      final response = await apiServices.getRequest(
        endpoint:
            Endpoints.getPosts(CacheManager.getData(key: Keys.userId) ?? ''),
        token: requestModel.token,
      );
      // map response to the model
      final responseModel = GetPostsResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DeletePostsResponseModel>> deletePost({
    required DeletePostRequestModel requestModel,
  }) async {
    try {
      // print(CacheManager.getData(key: Keys.userId) ?? '');
      // send request to the server
      final response = await apiServices.deleteRequest(
        endpoint: Endpoints.deletePost(requestModel.postId),
        token: requestModel.token,
      );
      // map response to the model
      final responseModel = DeletePostsResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UpdatePostResponseModel>> updatePost({
    required UpdatePostsRequestModel requestModel,
  }) async {
    try {
      // send request to the server
      final response = await apiServices.putRequest(
        endpoint: Endpoints.updatePost(requestModel.postId),
        token: requestModel.token,
        data:await requestModel.toJson(),
      );
      // map response to the model
      final responseModel = UpdatePostResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ?? 'An error occurred during create post',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, GetPostsResponseModel>> getPatientSocialPosts({
    required String token,
  }) async {
    try {
      // send request to the server
      final response = await apiServices.getRequest(
        endpoint: Endpoints.patientSocialPosts,
        token: token,
      );
      // map response to the model
      final responseModel = GetPostsResponseModel.fromJson(response.data);

      return Right(responseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
        e.response!.data['message'] ??
            'An error occurred during fetching patient social posts',
      ));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
