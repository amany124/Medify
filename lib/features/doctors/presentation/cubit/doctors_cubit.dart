import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/doctor_model.dart';
import '../../data/repos/doctors_repo.dart';

part 'doctors_state.dart';

class DoctorsCubit extends Cubit<DoctorsState> {
  final DoctorsRepo _doctorsRepo;

  DoctorsCubit({
    required DoctorsRepo doctorsRepo,
  })  : _doctorsRepo = doctorsRepo,
        super(DoctorsInitial());

  Future<void> searchDoctors({
    String? searchQuery,
    String? specialization,
    int? page,
    int? limit,
  }) async {
    emit(DoctorsLoading());

    final result = await _doctorsRepo.searchDoctors(
      searchQuery: searchQuery,
      specialization: specialization,
      page: page,
      limit: limit,
    );

    result.fold(
      (failure) => emit(DoctorsError(message: failure.message)),
      (doctors) => emit(DoctorsLoaded(doctors: doctors)),
    );
  }
}
