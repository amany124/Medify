import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/booking/data/models/scheduled_appointment.dart';
import 'package:medify/features/booking/data/repos/appointment_repo.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final AppointmentRepo appointmentRepo;

  NotificationCubit({required this.appointmentRepo})
      : super(NotificationInitial());

  Future<void> getUpcomingAppointments() async {
    if (isClosed) return; // Prevent emitting if cubit is closed

    emit(NotificationLoading());

    try {
      final role = CacheManager.getData(key: 'role');
      final result = role == 'Doctor'
          ? await appointmentRepo.getDoctorAppointments(type: 'upcoming')
          : await appointmentRepo.getPatientAppointments(type: 'upcoming');

      if (isClosed) return; // Check again before emitting result

      result.fold(
        (failure) {
          if (!isClosed) emit(NotificationError(failure.message));
        },
        (appointments) {
          if (!isClosed) {
            final groupedAppointments = _groupAppointmentsByDate(appointments);
            emit(NotificationLoaded(groupedAppointments));
          }
        },
      );
    } catch (e) {
      if (!isClosed) emit(NotificationError(e.toString()));
    }
  }

  Map<String, List<ScheduledAppointment>> _groupAppointmentsByDate(
      List<ScheduledAppointment> appointments) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    final Map<String, List<ScheduledAppointment>> grouped = {
      'Today': [],
      'Tomorrow': [],
      'Yesterday': [],
      'Other': [],
    };

    for (final appointment in appointments) {
      final appointmentDate = DateTime(
        appointment.date.year,
        appointment.date.month,
        appointment.date.day,
      );

      if (appointmentDate.isAtSameMomentAs(today)) {
        grouped['Today']!.add(appointment);
      } else if (appointmentDate.isAtSameMomentAs(tomorrow)) {
        grouped['Tomorrow']!.add(appointment);
      } else if (appointmentDate.isAtSameMomentAs(yesterday)) {
        grouped['Yesterday']!.add(appointment);
      } else {
        grouped['Other']!.add(appointment);
      }
    }

    // Sort appointments by time within each group
    grouped.forEach((key, appointments) {
      appointments.sort((a, b) => a.time.compareTo(b.time));
    });

    return grouped;
  }
}
