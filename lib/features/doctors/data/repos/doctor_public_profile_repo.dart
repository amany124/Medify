import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/constant/endpoints.dart';
import '../../../../core/failures/failure.dart';
import '../../../../core/services/api_service.dart';
import '../models/doctor_public_profile_model.dart';

abstract class DoctorPublicProfileRepo {
  Future<Either<Failure, DoctorPublicProfileModel>> getDoctorPublicProfile(
      String doctorId);
}

class DoctorPublicProfileRepoImpl implements DoctorPublicProfileRepo {
  final ApiServices _apiServices;

  DoctorPublicProfileRepoImpl({required ApiServices apiServices})
      : _apiServices = apiServices;

  @override
  Future<Either<Failure, DoctorPublicProfileModel>> getDoctorPublicProfile(
      String doctorId) async {
    try {
      final response = await _apiServices.getRequest(
          endpoint: '${Endpoints.doctorsPublicProfile}/$doctorId');
      return right(DoctorPublicProfileModel.fromJson(response.data));
    } catch (e) {
      if (e is DioException) {
        return left(Failure(e.toString()));
      }
      return left(Failure(e.toString()));
    }
  }
}
