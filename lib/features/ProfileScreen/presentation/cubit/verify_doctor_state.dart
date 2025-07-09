import 'package:medify/features/ProfileScreen/data/models/verification_image_response.dart';
abstract class VerifyDoctorState {}

class VerifyDoctorInitial extends VerifyDoctorState {}

class VerifyDoctorLoading extends VerifyDoctorState {}

class VerifyDoctorSuccess extends VerifyDoctorState {
  final VerificationImageResponse verification;

  VerifyDoctorSuccess(this.verification);
}

class VerifyDoctorError extends VerifyDoctorState {
  final String message;

  VerifyDoctorError(this.message);
}
