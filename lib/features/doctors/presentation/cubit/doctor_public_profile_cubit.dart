import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/doctor_public_profile_model.dart';
import '../../data/repos/doctor_public_profile_repo.dart';

part 'doctor_public_profile_state.dart';

class DoctorPublicProfileCubit extends Cubit<DoctorPublicProfileState> {
  final DoctorPublicProfileRepo _doctorPublicProfileRepo;

  DoctorPublicProfileCubit(
      {required DoctorPublicProfileRepo doctorPublicProfileRepo})
      : _doctorPublicProfileRepo = doctorPublicProfileRepo,
        super(DoctorPublicProfileInitial());

  Future<void> getDoctorPublicProfile(String doctorId) async {
    emit(DoctorPublicProfileLoading());
    final result =
        await _doctorPublicProfileRepo.getDoctorPublicProfile(doctorId);
    result.fold(
      (failure) => emit(DoctorPublicProfileError(failure.message)),
      (profile) => emit(DoctorPublicProfileLoaded(profile)),
    );
  }
}
