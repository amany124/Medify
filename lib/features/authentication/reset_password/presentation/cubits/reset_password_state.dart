import 'package:equatable/equatable.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}

class RequestResetPasswordLoading extends ResetPasswordState {}

class RequestResetPasswordSuccess extends ResetPasswordState {
  final String message;
  final String email;
  final String role;

  const RequestResetPasswordSuccess({
    required this.message,
    required this.email,
    required this.role,
  });

  @override
  List<Object> get props => [message, email, role];
}

class RequestResetPasswordFailure extends ResetPasswordState {
  final String message;

  const RequestResetPasswordFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class VerifyOtpLoading extends ResetPasswordState {}

class VerifyOtpSuccess extends ResetPasswordState {
  final String message;

  const VerifyOtpSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class VerifyOtpFailure extends ResetPasswordState {
  final String message;

  const VerifyOtpFailure({required this.message});

  @override
  List<Object> get props => [message];
}
