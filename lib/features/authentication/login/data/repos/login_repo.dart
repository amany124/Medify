import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';

import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/helpers/cache_manager.dart';
import '../../../../../core/services/api_service.dart';
import '../../../register/data/models/auth_response_model.dart';

abstract class LoginRepo {
  // Add your repository methods here
  Future<Either<Failure, AuthResponseModel>> login(
      {required LoginUserModel loginUserModel});
}

class LoginRepoImpl implements LoginRepo {
  final ApiServices apiServices;
  LoginRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, AuthResponseModel>> login(
      {required LoginUserModel loginUserModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.login,
        data: loginUserModel.toJson(),
      );
      final String token = response.data['token'];
      await CacheManager.setData(key: Keys.token, value: token);
      final authResponseModel = AuthResponseModel.fromJson(response.data);
      return Right(authResponseModel);
    } on DioException catch (e) {
      print(e.response?.data);
      return Left(Failure(
          e.response!.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
