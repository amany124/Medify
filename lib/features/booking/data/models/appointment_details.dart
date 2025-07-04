import 'package:equatable/equatable.dart';

class AppointmentDetails extends Equatable {
  final String? patientId;
  final String? doctorId;
  final DateTime? date;
  final String? time;
  final String? status;
  final String? reason;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  const AppointmentDetails({
    this.patientId,
    this.doctorId,
    this.date,
    this.time,
    this.status,
    this.reason,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AppointmentDetails.fromJson(Map<String, dynamic> json) {
    return AppointmentDetails(
      patientId: json['patientId'] as String?,
      doctorId: json['doctorId'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      time: json['time'] as String?,
      status: json['status'] as String?,
      reason: json['reason'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }
  //toJson
  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'doctorId': doctorId,
      'date': date?.toIso8601String(),
      'time': time,
      'status': status,
      'reason': reason,
      '_id': id,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
    };
  }

  @override
  List<Object?> get props {
    return [
      patientId,
      doctorId,
      date,
      time,
      status,
      reason,
      id,
      createdAt,
      updatedAt,
      v,
    ];
  }
}
