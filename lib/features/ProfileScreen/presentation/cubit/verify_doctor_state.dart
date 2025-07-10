import 'package:medify/features/ProfileScreen/data/models/profile_picture_response.dart';
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

// Profile Picture Upload States
class ProfilePictureUploadLoading extends VerifyDoctorState {}

class ProfilePictureUploadSuccess extends VerifyDoctorState {
  final ProfilePictureResponse profilePicture;

  ProfilePictureUploadSuccess(this.profilePicture);
}

class ProfilePictureUploadError extends VerifyDoctorState {
  final String message;

  ProfilePictureUploadError(this.message);
}
