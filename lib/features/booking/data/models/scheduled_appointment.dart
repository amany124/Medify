import 'doctor.dart';
import 'patient.dart';

class ScheduledAppointment {
  final String id;
  final Patient patient;
  final Doctor doctor;
  final DateTime date;
  final String time;
  final String status;
  final String reason;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScheduledAppointment({
    required this.id,
    required this.patient,
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
    required this.reason,
    required this.createdAt,
    required this.updatedAt,
  });

  // From JSON
  factory ScheduledAppointment.fromJson(Map<String, dynamic> json) {
    return ScheduledAppointment(
      id: json['_id'],
      patient: Patient.fromJson(json['patientId']),
      doctor: Doctor.fromJson(json['doctorId']),
      date: DateTime.parse(json['date']),
      time: json['time'],
      status: json['status'],
      reason: json['reason'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'patientId': patient.toJson(),
      'doctorId': doctor.toJson(),
      'date': date.toIso8601String(),
      'time': time,
      'status': status,
      'reason': reason,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
