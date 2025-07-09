part of 'notification_cubit.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationLoaded extends NotificationState {
  final Map<String, List<ScheduledAppointment>> groupedAppointments;

  NotificationLoaded(this.groupedAppointments);
}

class NotificationError extends NotificationState {
  final String message;

  NotificationError(this.message);
}
