import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/doctors/data/models/doctor_model.dart';
import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

abstract class DoctorsRepo {
  Future<Either<Failure, List<DoctorModel>>> searchDoctors({
    String? searchQuery,
    String? specialization,
    int? page,
    int? limit,
  });
}

class DoctorsRepoImpl implements DoctorsRepo {
  final ApiServices apiServices;

  DoctorsRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, List<DoctorModel>>> searchDoctors({
    String? searchQuery,
    String? specialization,
    int? page,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParams = {};

      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['search'] = searchQuery;
      }

      if (specialization != null && specialization.isNotEmpty) {
        queryParams['specialization'] = specialization;
      }

      if (page != null) {
        queryParams['page'] = page.toString();
      }

      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }

      final endpoint = Endpoints.searchDoctors + _buildQueryString(queryParams);
      print(endpoint);
      final Response response = await apiServices.getRequest(
        endpoint: endpoint,
        token: CacheManager.getData(key: Keys.token),
      );

      final List<DoctorModel> doctors = (response.data['data'] as List)
          .map((doctor) => DoctorModel.fromJson(doctor))
          .toList();

      return Right(doctors);
    } on DioException catch (e) {
      return Left(
          Failure(e.response?.data['message'] ?? 'Failed to fetch doctors'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  String _buildQueryString(Map<String, dynamic> params) {
    if (params.isEmpty) return '';

    return '?${params.entries.map((entry) => '${entry.key}=${Uri.encodeComponent(entry.value)}').join('&')}';
  }
}
