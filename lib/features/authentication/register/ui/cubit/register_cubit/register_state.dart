part of 'register_cubit.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final UserModel registerUserModel;

  RegisterSuccess(this.registerUserModel);
}

final class RegisterFailure extends RegisterState {
  final Failure failure;

  RegisterFailure(this.failure);
}