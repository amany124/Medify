import 'package:medify/features/booking/data/models/scheduled_appointment.dart';

import '../../data/models/appointment_details.dart';

abstract class AppointmentState {}

class AppointmentInitialState extends AppointmentState {}

class AppointmentLoadingState extends AppointmentState {}

class AppointmentCreatedSuccessState extends AppointmentState {
  final AppointmentDetails appointmentDetails;
  AppointmentCreatedSuccessState(this.appointmentDetails);
}
//secheduled appointment state
class AppointmentScheduledState extends AppointmentState {
  final List<ScheduledAppointment> scheduledAppointments;
  AppointmentScheduledState(this.scheduledAppointments);
}
class AppointmentErrorState extends AppointmentState {
  final String errorMessage;
  AppointmentErrorState(this.errorMessage);
}

class AppointmentUpdatedState extends AppointmentState {
  final String message;
  AppointmentUpdatedState(this.message);
}