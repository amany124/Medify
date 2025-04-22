import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';
import 'package:medify/features/authentication/register/data/models/response_user_model.dart';

import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/services/api_service.dart';

abstract class LoginRepo {
  // Add your repository methods here
  Future<Either<Failure, ResponseUserModel>> login(
      {required LoginUserModel loginUserModel});
}

class LoginRepoImpl implements LoginRepo {
  final ApiServices apiServices;
  LoginRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, ResponseUserModel>> login(
      {required LoginUserModel loginUserModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.login,
        data: loginUserModel.toJson(),
      );
      final String token = response.data['token'];
      //TODO: save token in shared preferences
      return Right(ResponseUserModel.fromJson(response.data['user']));
    } on DioException catch (e) {
      print(e.response!.data);
      return Left(Failure(
          e.response!.data['message'] ?? 'An error occurred during login'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
