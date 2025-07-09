import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/medical_records/data/models/medical_record.dart';
import 'package:medify/features/medical_records/data/models/medical_records_response.dart';
import 'package:medify/features/medical_records/data/repos/medical_records_repo.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

class MedicalRecordsRepoImpl implements MedicalRecordsRepo {
  final ApiServices apiServices;

  MedicalRecordsRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, MedicalRecord>> createMedicalRecord({
    required MedicalRecord medicalRecord,
  }) async {
    try {

      final response = await apiServices.postRequest(
        endpoint: '${Endpoints.baseUrl}/api/medical-records/reports',
        data: medicalRecord.toJson(),
        token: CacheManager.getData(
            key: Keys.token,
          ));
    

      log('MedicalRecordsRepoImpl: API call successful');
      log('MedicalRecordsRepoImpl: Response: ${response.data}');

      return Right(MedicalRecord.fromJson(response.data['report']));
    } on DioException catch (e) {
      log('MedicalRecordsRepoImpl: DioException occurred: ${e.message}');
      log('MedicalRecordsRepoImpl: Response data: ${e.response?.data}');
      return Left(Failure(
          e.response?.data['message'] ?? 'An error occurred during creation'));
    } catch (e) {
      log('MedicalRecordsRepoImpl: General exception occurred: $e');
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, MedicalRecordsResponse>> getMedicalRecords() async {
    try {
      final response = await apiServices.getRequest(
        endpoint: '${Endpoints.baseUrl}/api/medical-records/reports',
        token: CacheManager.getData(
            key: Keys.token,
          ));
    

      final medicalRecordsResponse =
          MedicalRecordsResponse.fromJson(response.data);

      return Right(medicalRecordsResponse);
    } on DioException catch (e) {
      return Left(Failure(e.response!.data['message'] ??
          'An error occurred while fetching records'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
