import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart';

class DoctorAppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;

  DoctorAppointmentCubit({required this.appointmentRepo})
      : super(AppointmentInitialState());

  Future<void> getDoctorUpcomingAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getDoctorAppointments(
      type: 'upcoming',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  Future<void> getDoctorCompletedAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getDoctorAppointments(
      type: 'completed',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  Future<void> getDoctorCancelledAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getDoctorAppointments(
      type: 'cancelled',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  Future<void> updateDocAppointment({
    required String appointmentId,
    required String status,
  }) async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.updateDocAppointment(
      appointmentId: appointmentId,
      status: status,
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (message) => emit(AppointmentUpdatedState(message)),
    );
  }

}
