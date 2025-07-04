import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/doctors/data/models/favorite_doctor_model.dart';

import '../../../../core/constant/endpoints.dart';
import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

abstract class FavoriteDoctorsRepo {
  Future<Either<Failure, bool>> addDoctorToFavorites({
    required String doctorId,
  });

  Future<Either<Failure, List<FavoriteDoctorModel>>> getFavoriteDoctors();

  Future<Either<Failure, bool>> removeDoctorFromFavorites({
    required String doctorId,
  });
}

class FavoriteDoctorsRepoImpl implements FavoriteDoctorsRepo {
  final ApiServices apiServices;

  FavoriteDoctorsRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, bool>> addDoctorToFavorites({
    required String doctorId,
  }) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: '${Endpoints.patientFavorites}/$doctorId',
        data: {},
        token: CacheManager.getData(key: Keys.token),
      );

      return const Right(true);
    } on DioException catch (e) {
      return Left(Failure(
          e.response?.data['message'] ?? 'Failed to add doctor to favorites'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<FavoriteDoctorModel>>>
      getFavoriteDoctors() async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.patientFavorites,
        token: CacheManager.getData(key: Keys.token),
      );

      final List<FavoriteDoctorModel> doctors =
          (response.data as List)
              .map((doctor) => FavoriteDoctorModel.fromJson(doctor))
              .toList();

      return Right(doctors);
    } on DioException catch (e) {
      return Left(Failure(
          e.response?.data['message'] ?? 'Failed to fetch favorite doctors'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeDoctorFromFavorites({
    required String doctorId,
  }) async {
    try {
      final Response response = await apiServices.deleteRequest(
        endpoint: '${Endpoints.patientFavorites}/$doctorId',
        token: CacheManager.getData(key: Keys.token),
      );

      return const Right(true);
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'Failed to remove doctor from favorites'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
