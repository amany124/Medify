import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_request_model.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_response.dart';

abstract class PredictDiseaseRepo {
  Future<Either<Failure, HeartDiseasesResponse>> predictDisease(
      {required HeartDiseasesRequest request});
}

class PredictDiseaseRepoImpl implements PredictDiseaseRepo {
  final ApiServices apiServices;
  PredictDiseaseRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, HeartDiseasesResponse>> predictDisease({
    required HeartDiseasesRequest request,
  }) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.predictDisease,
        data: request.toJson(),
      );
      print(response.toString());

      final HeartDiseasesResponse heartDiseasesResponse =
          HeartDiseasesResponse.fromJson(response.data);
      return Right(heartDiseasesResponse);
    } on DioException catch (e) {
      print(e);
      return Left(Failure(
          e.response?.data['message'] ?? 'Failed to add doctor to favorites'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
