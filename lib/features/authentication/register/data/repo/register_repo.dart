import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';
import 'package:medify/features/authentication/register/data/models/response_user_model.dart';

abstract class RegisterRepo {
  Future<Either<Failure, ResponseUserModel>> registerDoctor(
      {required DoctorModel doctorModel});
  Future<Either<Failure, ResponseUserModel>> registerPatient(
      {required PatientModel patientModel});
}

class RegisterRepoImpl implements RegisterRepo {
  final ApiServices apiServices;

  RegisterRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, ResponseUserModel>> registerDoctor(
      {required DoctorModel doctorModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.register,
        data: doctorModel.toJson(),
      );
      final String token = response.data['token'];
      //TODO: save token in shared preferences
      return Right(ResponseUserModel.fromJson(response.data['user']));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(e.response!.data['message'] ??
          'An error occurred during registration'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseUserModel>> registerPatient(
      {required PatientModel patientModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.register,
        data: patientModel.toJson(),
      );
      final String token = response.data['token'];
      //TODO: save token in shared preferences
      return Right(ResponseUserModel.fromJson(response.data['user']));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(e.response!.data['message'] ??
          'An error occurred during registration'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
<<<<<<< HEAD


=======
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
