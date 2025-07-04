import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:medify/core/constant/endpoints.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/authentication/reset_password/data/models/reset_password_request_model.dart';

abstract class ResetPasswordRepo {
  Future<Either<Failure, String>> requestResetPassword(
      {required RequestResetPasswordModel requestModel});
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordModel resetModel});
}

class ResetPasswordRepoImpl implements ResetPasswordRepo {
  final ApiServices apiServices;

  ResetPasswordRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, String>> requestResetPassword(
      {required RequestResetPasswordModel requestModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.requestResetPassword,
        data: requestModel.toJson(),
      );

      return Right(response.data['message'] ?? 'OTP sent to your email');
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while requesting password reset'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword(
      {required ResetPasswordModel resetModel}) async {
    try {
      final Response response = await apiServices.postRequest(
        endpoint: Endpoints.resetPassword,
        data: resetModel.toJson(),
      );

      return Right(response.data['message'] ?? 'Password reset successful');
    } on DioException catch (e) {
      return Left(Failure(e.response?.data['message'] ??
          'An error occurred while resetting the password'));
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
