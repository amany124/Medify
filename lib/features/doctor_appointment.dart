import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/theme/app_colors.dart' show AppColors;
import 'package:medify/features/booking/presentation/cubit/Doctor_appointment_cubit.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart';

import '../core/services/api_service.dart';
import 'booking/data/repos/appointment_repo.dart';

class DoctorAppointment extends StatelessWidget {
  const DoctorAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorAppointmentCubit(
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
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
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

    return BlocListener<DoctorAppointmentCubit, AppointmentState>(
      listener: (context, state) {
        if (state is AppointmentUpdatedState) {
          if (status == "Upcoming") {
            context
                .read<DoctorAppointmentCubit>()
                .getDoctorUpcomingAppointments();
          } else if (status == "Completed") {
            context
                .read<DoctorAppointmentCubit>()
                .getDoctorCompletedAppointments();
          } else if (status == "Cancelled") {
            context
                .read<DoctorAppointmentCubit>()
                .getDoctorCancelledAppointments();
          }

          showCustomSnackBar('Appointment updated successfully', context);
        }
      },
      child: BlocBuilder<DoctorAppointmentCubit, AppointmentState>(
        builder: (context, state) {
          if (state is AppointmentLoadingState) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.secondaryColor),
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
                      borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  color: const Color(0xffffffff),
                  shadowColor: Colors.grey[300],
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/images/doctor.png',
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appointment.time,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    appointment.reason,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Row(
                                    children: [
                                      Text(
                                        appointment.status,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: status == "Cancelled"
                                              ? Colors.redAccent
                                              : status == "Upcoming"
                                                  ? AppColors.secondaryColor
                                                  : Colors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      if (status == "Cancelled")
                                        const Icon(Icons.cancel,
                                            color: Colors.red, size: 14),
                                      if (status == "Completed")
                                        const Icon(Icons.check_circle,
                                            color: Colors.green, size: 14),
                                      if (status == "Upcoming")
                                        const Icon(Icons.schedule,
                                            color: AppColors.secondaryColor,
                                            size: 14),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            if (status == "Upcoming")
                              const Icon(Icons.schedule,
                                  color: AppColors.secondaryColor, size: 18),
                          ],
                        ),
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
    final cubit = context.read<DoctorAppointmentCubit>();
    switch (status) {
      case "Upcoming":
        cubit.getDoctorUpcomingAppointments();
        break;
      case "Completed":
        cubit.getDoctorCompletedAppointments();
        break;
      case "Cancelled":
        cubit.getDoctorCancelledAppointments();
        break;
    }
  }
}
