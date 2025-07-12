import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/booking/data/models/scheduled_appointment.dart';

class AppointmentNotificationTile extends StatelessWidget {
  final ScheduledAppointment appointment;
  final String timeAgo;

  const AppointmentNotificationTile({
    super.key,
    required this.appointment,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2260FF).withValues(alpha:0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: const Color(0xFFE8F1FF),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: _getStatusColor().withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              _getStatusIcon(),
              color: _getStatusColor(),
              size: 24,
            ),
          ),
          const SizedBox(width: 15),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getNotificationTitle(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1B5A8C),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _getNotificationSubtitle(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A6C7D),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16,
                      color: const Color(0xFF7F8C8D),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${appointment.time} • ${DateFormat('MMM dd').format(appointment.date)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF7F8C8D),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Time ago
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2260FF).withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeAgo,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF2260FF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getNotificationTitle() {
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        return 'Appointment Confirmed';
      case 'pending':
        return 'Appointment Pending';
      case 'cancelled':
        return 'Appointment Cancelled';
      case 'completed':
        return 'Appointment Completed';
      default:
        return 'Appointment Update';
    }
  }

  String _getNotificationSubtitle() {
    final userRole = CacheManager.getData(key: Keys.role) ?? 'patient';
    final reason = appointment.reason.isNotEmpty
        ? appointment.reason
        : 'General consultation';

    if (userRole.toLowerCase() == 'doctor') {
      // If user is a doctor, show patient name
      final patientName = appointment.patient.name;
      return 'Appointment with $patientName for $reason';
    } else {
      // If user is a patient, show doctor name
      final doctorName = appointment.doctor!.name;
      return 'Appointment with Dr. $doctorName for $reason';
    }
  }

  IconData _getStatusIcon() {
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle_outline;
      case 'pending':
        return Icons.schedule;
      case 'cancelled':
        return Icons.cancel_outlined;
      case 'completed':
        return Icons.task_alt;
      default:
        return Icons.event;
    }
  }

  Color _getStatusColor() {
    switch (appointment.status.toLowerCase()) {
      case 'confirmed':
        return const Color(0xFF27AE60); // Professional green
      case 'pending':
        return const Color(0xFFF39C12); // Professional orange
      case 'cancelled':
        return const Color(0xFFE74C3C); // Professional red
      case 'completed':
        return const Color(0xFF2260FF); // App primary blue
      default:
        return const Color(0xFF7F8C8D); // Professional grey
    }
  }
}
