import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/booking/data/models/appointment_request_model.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart';

class PatientAppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepo appointmentRepo;

  PatientAppointmentCubit({required this.appointmentRepo})
      : super(AppointmentInitialState());

  Future<void> createAppointment({
    required AppointmentRequestModel appointmentRequestModel,
  }) async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.createAppointment(
        appointmentRequestModel: appointmentRequestModel);
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentCreatedSuccessState(response)),
    );
  }

  ///getPatientAppointments
  Future<void> getPatientUpcomingAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getPatientAppointments(
      type: 'upcoming',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  Future<void> getPatientCompletedAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getPatientAppointments(
      type: 'completed',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  Future<void> getPatientCancelledAppointments() async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.getPatientAppointments(
      type: 'cancelled',
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentScheduledState(response)),
    );
  }

  //updateAppointment
  Future<void> updatePatientAppointment({
    required String appointmentId,
    required String status,
  }) async {
    emit(AppointmentLoadingState());
    final result = await appointmentRepo.updatePatientAppointment(
      appointmentId: appointmentId,
      status: status,
    );
    result.fold(
      (failure) => emit(AppointmentErrorState(failure.message)),
      (response) => emit(AppointmentUpdatedState(response)),
    );
  }
}
