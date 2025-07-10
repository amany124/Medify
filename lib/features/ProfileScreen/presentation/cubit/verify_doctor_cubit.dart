import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/ProfileScreen/data/repos/profile_repo.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_state.dart';

class VerifyDoctorCubit extends Cubit<VerifyDoctorState> {
  final ProfileRepo profileRepo;

  VerifyDoctorCubit({required this.profileRepo}) : super(VerifyDoctorInitial());

  Future<void> verifyDoctorProfile({required File imageFile}) async {
    if (isClosed) return;

    emit(VerifyDoctorLoading());

    try {
      final result =
          await profileRepo.verifyDoctorProfile(imageFile: imageFile);

      if (isClosed) return;

      result.fold(
        (failure) {
          if (!isClosed) emit(VerifyDoctorError(failure.message));
        },
        (verification) {
          if (!isClosed) emit(VerifyDoctorSuccess(verification));
        },
      );
    } catch (e) {
      if (!isClosed) emit(VerifyDoctorError(e.toString()));
    }
  }

  Future<void> uploadDoctorProfilePicture({required File imageFile}) async {
    if (isClosed) return;

    emit(ProfilePictureUploadLoading());

    try {
      final result =
          await profileRepo.uploadDoctorProfilePicture(imageFile: imageFile);

      if (isClosed) return;

      result.fold(
        (failure) {
          if (!isClosed) emit(ProfilePictureUploadError(failure.message));
        },
        (profilePicture) {
          if (!isClosed) emit(ProfilePictureUploadSuccess(profilePicture));
        },
      );
    } catch (e) {
      if (!isClosed) emit(ProfilePictureUploadError(e.toString()));
    }
  }

  void resetState() {
    if (!isClosed) emit(VerifyDoctorInitial());
  }
}
