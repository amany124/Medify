import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/routing/routes.dart';
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
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, Routes.availability),
            icon: const Icon(Icons.schedule, size: 18),
            label: const Text("Schedule Availability"),
            backgroundColor: const Color(0xff1877F2),
            foregroundColor: Colors.white,
          ),
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
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
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
                    color: Colors.grey,
                  ),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return _buildAppointmentCard(context, appointment);
              },
            );
          } else {
            return const Center(child: Text('No appointments available.'));
          }
        },
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, dynamic appointment) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: const Color(0xffffffff),
      shadowColor: Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPatientImage(),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (status == "Cancelled") _buildCancelledHeader(),
                      _buildPatientName(appointment),
                      const SizedBox(height: 6),
                      _buildDateTimeInfo(appointment),
                      const SizedBox(height: 6),
                      _buildReasonInfo(appointment),
                      const SizedBox(height: 8),
                      _buildStatusBadge(appointment),
                    ],
                  ),
                ),
              ],
            ),
            if (status == "Upcoming") ...[
              const SizedBox(height: 16),
              const Divider(
                height: 1,
                thickness: 1,
                color: Color(0xFFEEEEEE),
              ),
              const SizedBox(height: 16),
              _buildActionButtons(context, appointment),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPatientImage() {
    return Container(
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
          'assets/images/patient.jpg',
          width: 90,
          height: 90,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildCancelledHeader() {
    return const Text(
      "Appointment Cancelled",
      style: TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildPatientName(dynamic appointment) {
    return Text(
      "Patient: ${appointment.patient.name}",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildDateTimeInfo(dynamic appointment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F7FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD6E8FF), width: 1),
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
    );
  }

  Widget _buildReasonInfo(dynamic appointment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xff1877F2).withValues(alpha: 0.1),
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
    );
  }

  Widget _buildStatusBadge(dynamic appointment) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _getStatusColor().withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _getStatusColor().withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _getStatusIcon(),
          const SizedBox(width: 4),
          Text(
            appointment.status,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _getStatusColor(),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (status) {
      case "Cancelled":
        return Colors.red;
      case "Completed":
        return Colors.green;
      case "Upcoming":
      default:
        return const Color(0xff1877F2);
    }
  }

  Widget _getStatusIcon() {
    switch (status) {
      case "Cancelled":
        return const Icon(Icons.cancel, color: Colors.red, size: 16);
      case "Completed":
        return const Icon(Icons.check_circle, color: Colors.green, size: 16);
      case "Upcoming":
      default:
        return const Icon(Icons.schedule, color: Color(0xff1877F2), size: 16);
    }
  }

  Widget _buildActionButtons(BuildContext context, dynamic appointment) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            // Navigate to medical record creation page using named route
            final result = await Navigator.pushNamed(
              context,
              Routes.createMedicalRecord,
              arguments: appointment,
            );

            // If medical record was created successfully, update appointment status
            if (result == true && context.mounted) {
              context.read<DoctorAppointmentCubit>().updateDocAppointment(
                    appointmentId: appointment.id,
                    status: "Completed",
                  );
            }
          },
          icon: const Icon(Icons.medical_information, size: 18),
          label: const Text("Complete"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff1877F2),
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () {
            context.read<DoctorAppointmentCubit>().updateDocAppointment(
                  appointmentId: appointment.id,
                  status: "Cancelled",
                );
          },
          icon: const Icon(Icons.cancel, size: 18),
          label: const Text("Cancel"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            elevation: 3,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
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

  String _formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }
}
