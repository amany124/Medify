import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/ProfileScreen/data/models/profile_picture_response.dart';
import 'package:medify/features/ProfileScreen/data/models/verification_image_response.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

import '../../../../core/constant/endpoints.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/keys.dart';

abstract class ProfileRepo {
  Future<Either<Failure, PatientModel>> getPatientProfile();
  Future<Either<Failure, PatientModel>> updatePatientProfile({
    required PatientModel patientModel,
  });
  Future<Either<Failure, DoctorModel>> getDoctorProfile();
  Future<Either<Failure, DoctorModel>> updateDoctorProfile({
    required DoctorModel doctorModel,
  });
  //verfiy doctor
  Future<Either<Failure, VerificationImageResponse>> verifyDoctorProfile(
      {required File imageFile});
  //upload profilePic
  Future<Either<Failure, ProfilePictureResponse>> uploadDoctorProfilePicture({
    required File imageFile,
  });
  //get patient profile by id
  Future<Either<Failure, PatientModel>> getPatientProfileById(
      {required String patientId}
  );
}

class ProfileRepoImpl implements ProfileRepo {
  final ApiServices apiServices;
  ProfileRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, PatientModel>> getPatientProfile() async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.patientProfile,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      print(response.data);
      return Right(PatientModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
          e.response!.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PatientModel>> updatePatientProfile({
    required PatientModel patientModel,
  }) async {
    try {
      final Response response = await apiServices.putRequest(
        endpoint: Endpoints.patientProfile,
        token: CacheManager.getData(
          key: Keys.token,
        ),
        data: patientModel.toJson(),
      );
      return Right(PatientModel.fromJson(response.data['data']));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
          e.response!.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> getDoctorProfile() async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.doctorProfile,
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right(DoctorModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response?.data);
      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during login'));
    }
  }

  @override
  Future<Either<Failure, DoctorModel>> updateDoctorProfile(
      {required DoctorModel doctorModel}) async {
    try {
      final Response response = await apiServices.putRequest(
        endpoint: Endpoints.doctorProfile,
        token: CacheManager.getData(
          key: Keys.token,
        ),
        data: doctorModel.toJson(),
      );
      return Right(DoctorModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
          e.response!.data['message'] ?? 'An error occurred during login'));
    }
  }

  @override
  Future<Either<Failure, VerificationImageResponse>> verifyDoctorProfile({
    required File imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      final Response response = await apiServices.dio.post(
        Endpoints.verifyDoctorProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheManager.getData(key: Keys.token)}',
          },
        ),
      );

      return Right(VerificationImageResponse.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response?.data);
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred during verification'));
    }
  }

  @override
  Future<Either<Failure, ProfilePictureResponse>> uploadDoctorProfilePicture({
    required File imageFile,
  }) async {
    try {
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(imageFile.path),
      });

      final Response response = await apiServices.dio.post(
        Endpoints.doctorProfilePicture,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${CacheManager.getData(key: Keys.token)}',
          },
        ),
      );

      return Right(ProfilePictureResponse.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response?.data);
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred during profile picture upload'));
    }
  }
  @override
  Future<Either<Failure, PatientModel>> getPatientProfileById(
      {required String patientId}) async {
    try {
      final Response response = await apiServices.getRequest(
        endpoint: Endpoints.patientProfileById(patientId),
        token: CacheManager.getData(
          key: Keys.token,
        ),
      );
      return Right(PatientModel.fromJson(response.data));
    } on DioException catch (e) {
      print(e.response?.data);
      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during profile fetch'));
    }
  }
}
//
