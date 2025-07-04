import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart';
import 'package:medify/features/booking/presentation/cubit/patient_appointment_cubit.dart';

import '../core/services/api_service.dart';
import '../core/theme/app_colors.dart';
import 'booking/data/repos/appointment_repo.dart';

class PatientAppointment extends StatelessWidget {
  const PatientAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PatientAppointmentCubit(
        appointmentRepo: AppointmentRepoImpl(apiServices: ApiServices(Dio())),
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text(
              "My Appointments",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            bottom: const TabBar(
              labelColor: Color(0xff1877F2),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xff1877F2),
              indicatorWeight: 3,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Completed"),
                Tab(text: "Cancelled"),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              AppointmentsList(status: "Upcoming"),
              AppointmentsList(status: "Completed"),
              AppointmentsList(status: "Cancelled"),
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentsList extends StatelessWidget {
  final String status;

  const AppointmentsList({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    _loadAppointments(context, status);

    return BlocListener<PatientAppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentUpdatedState) {
          if (status == "Upcoming") {
            context
                .read<PatientAppointmentCubit>()
                .getPatientUpcomingAppointments();
          } else if (status == "Completed") {
            context
                .read<PatientAppointmentCubit>()
                .getPatientCompletedAppointments();
          } else if (status == "Cancelled") {
            context
                .read<PatientAppointmentCubit>()
                .getPatientCancelledAppointments();
          }

          showCustomSnackBar('Appointment updated successfully', context);
        }
      },
      child: BlocBuilder<PatientAppointmentCubit, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 8, 98, 216)),
            );
          } else if (state is AppointmentErrorState) {
            return Center(
              child: Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w600),
              ),
            );
          } else if (state is AppointmentScheduledState) {
            final appointments = state.scheduledAppointments;
            if (appointments.isEmpty) {
              return Center(
                child: Text(
                  'No $status appointments available.',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 6,
                  color: const Color(0xffffffff),
                  shadowColor: const Color(0xff1877F2).withValues(alpha: 0.2),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.1),
                                    spreadRadius: 1,
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  'assets/images/doctor_icon.png',
                                  width: 90,
                                  height: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (status == "Cancelled")
                                    const Text(
                                      "Appointment Cancelled",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  Text(
                                    "Dr. ${appointment.doctor.name}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    appointment.doctor.specialization,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF1F7FF),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: const Color(0xFFD6E8FF),
                                          width: 1),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.calendar_today,
                                          size: 14,
                                          color: Color(0xff1877F2),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          "${_formatDate(appointment.date)} · ${appointment.time}",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xff1877F2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff1877F2)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      appointment.reason,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff1877F2),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: status == "Cancelled"
                                          ? Colors.red.withValues(alpha: 0.1)
                                          : status == "Upcoming"
                                              ? const Color(0xff1877F2)
                                                  .withValues(alpha: 0.1)
                                              : Colors.green
                                                  .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: status == "Cancelled"
                                            ? Colors.red.withValues(alpha: 0.3)
                                            : status == "Upcoming"
                                                ? const Color(0xff1877F2)
                                                    .withValues(alpha: 0.3)
                                                : Colors.green
                                                    .withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (status == "Cancelled")
                                          const Icon(Icons.cancel,
                                              color: Colors.red, size: 16),
                                        if (status == "Completed")
                                          const Icon(Icons.check_circle,
                                              color: Colors.green, size: 16),
                                        if (status == "Upcoming")
                                          const Icon(Icons.schedule,
                                              color: Color(0xff1877F2),
                                              size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          appointment.status,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: status == "Cancelled"
                                                ? Colors.red
                                                : status == "Upcoming"
                                                    ? const Color(0xff1877F2)
                                                    : Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (status == "Upcoming")
                              const Icon(Icons.schedule,
                                  color: AppColors.secondaryColor, size: 18),
                          ],
                        ),
                        if (status == "Upcoming") ...[
                          const SizedBox(height: 16),
                          const Divider(
                              height: 1,
                              thickness: 1,
                              color: Color(0xFFEEEEEE)),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              OutlinedButton.icon(
                                onPressed: () {
                                  context
                                      .read<PatientAppointmentCubit>()
                                      .updatePatientAppointment(
                                        appointmentId: appointment.id,
                                        status: "Cancelled",
                                      );
                                },
                                icon:
                                    const Icon(Icons.cancel, color: Colors.red),
                                label: const Text("Cancel",
                                    style: TextStyle(color: Colors.red)),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                      color: Colors.red, width: 1.5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No appointments available.'));
          }
        },
      ),
    );
  }

  void _loadAppointments(BuildContext context, String status) {
    final cubit = context.read<PatientAppointmentCubit>();
    switch (status) {
      case "Upcoming":
        cubit.getPatientUpcomingAppointments();
        break;
      case "Completed":
        cubit.getPatientCompletedAppointments();
        break;
      case "Cancelled":
        cubit.getPatientCancelledAppointments();
        break;
    }
  }

  // Helper method to format date
  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
