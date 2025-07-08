import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/authentication/register/data/models/auth_response_model.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

import '../../../../../core/helpers/cache_manager.dart';

abstract class RegisterRepo {
  Future<Either<Failure, AuthResponseModel>> registerDoctor(
      {required DoctorModel doctorModel});
  Future<Either<Failure, AuthResponseModel>> registerPatient(
      {required PatientModel patientModel});
}

class RegisterRepoImpl implements RegisterRepo {
  final ApiServices apiServices;

  RegisterRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, AuthResponseModel>> registerDoctor(
      {required DoctorModel doctorModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.register,
        data: doctorModel.toJson(),
      );
      final String token = response.data['token'];
      print('Token: $token');
      await CacheManager.setData(key: Keys.token, value: token);
      AuthResponseModel authResponseModel =
          AuthResponseModel.fromJson(response.data);
      return Right(authResponseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(e.response!.data['message'] ??
          'An error occurred during registration'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> registerPatient(
      {required PatientModel patientModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.register,
        data: patientModel.toJson(),
      );
        final String token = response.data['token'];
      print('Token: $token');
      await CacheManager.setData(key: Keys.token, value: token);
      final authResponseModel = AuthResponseModel.fromJson(response.data);
      return Right(authResponseModel);
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(e.response!.data['message'] ??
          'An error occurred during registration'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
