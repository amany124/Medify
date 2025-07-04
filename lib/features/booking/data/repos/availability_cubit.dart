import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/core/features/availability_model.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';

import 'availability_state.dart';

class AvailabilityCubit extends Cubit<AvailabilityState> {
  final AppointmentRepo appointmentRepo;

  AvailabilityCubit({required this.appointmentRepo})
      : super(AvailabilityInitial());

  Future<void> fetchAvailability() async {
    emit(AvailabilityLoading());
    final Either<Failure, List<Availability>> result =
        await appointmentRepo.getAvailability();
    result.fold(
      (failure) => emit(AvailabilityError(failure.message)),
      (availability) => emit(AvailabilityLoaded(availability)),
    );
  }

  Future<void> updateAvailability(List<Availability> availabilityList) async {
    emit(AvailabilityLoading());
    final Either<Failure, String> result =
        await appointmentRepo.updateAvailability(
      availabilityList: availabilityList,
    );
    result.fold(
      (failure) => emit(AvailabilityError(failure.message)),
      (message) => emit(
        AvailabilityUpdated(
          message,
        ),
      ),
    );
  }
  Future<void> getAvailabilityById(String id) async {
    emit(AvailabilityLoading());
    final Either<Failure, List<Availability>> result =
        await appointmentRepo.getAvailabilityById(id: id);
    result.fold(
      (failure) => emit(AvailabilityError(failure.message)),
      (availability) => emit(AvailabilityLoaded(availability)),
    );
  }
}
