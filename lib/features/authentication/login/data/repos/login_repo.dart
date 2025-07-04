import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/failures/failure.dart';
<<<<<<< HEAD
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';

import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/helpers/cache_manager.dart';
import '../../../../../core/services/api_service.dart';
import '../../../register/data/models/response_user_model.dart';
=======
<<<<<<< HEAD
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';
import 'package:medify/features/authentication/register/data/models/response_user_model.dart';
import '../../../../../core/constant/endpoints.dart';
import '../../../../../core/helpers/cache_manager.dart';
=======
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';
import 'package:medify/features/authentication/register/data/models/response_user_model.dart';

import '../../../../../core/constant/endpoints.dart';
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
import '../../../../../core/services/api_service.dart';
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03

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
<<<<<<< HEAD
      await CacheManager.setData(key: Keys.token, value: token);
=======
      //TODO: save token in shared preferences
<<<<<<< HEAD
      print(token);
      await CacheManager.setData(key: Keys.token, value: token);
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
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
