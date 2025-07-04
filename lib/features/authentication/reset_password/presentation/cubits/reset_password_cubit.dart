import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/authentication/reset_password/data/models/reset_password_request_model.dart';
import 'package:medify/features/authentication/reset_password/data/repos/reset_password_repo.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ResetPasswordRepo resetPasswordRepo;

  ResetPasswordCubit({required this.resetPasswordRepo})
      : super(ResetPasswordInitial());

  Future<void> requestResetPassword(
      {required String email, required String role}) async {
    emit(RequestResetPasswordLoading());

    final requestModel = RequestResetPasswordModel(email: email, role: role);
    final result = await resetPasswordRepo.requestResetPassword(
        requestModel: requestModel);

    result.fold(
      (failure) =>
          emit(RequestResetPasswordFailure(message: failure.message)),
      (message) => emit(RequestResetPasswordSuccess(
          message: message, email: email, role: role)),
    );
  }

  Future<void> resetPassword({
    required String email,
    required String role,
    required String otp,
    required String newPassword,
  }) async {
    emit(VerifyOtpLoading());

    final resetModel = ResetPasswordModel(
      email: email,
      role: role,
      otp: otp,
      newPassword: newPassword,
    );

    final result =
        await resetPasswordRepo.resetPassword(resetModel: resetModel);

    result.fold(
      (failure) => emit(VerifyOtpFailure(message: failure.message)),
      (message) => emit(VerifyOtpSuccess(message: message)),
    );
  }
}
