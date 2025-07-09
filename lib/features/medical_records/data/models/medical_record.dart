class MedicalRecord {
  final String? id;
  final String patientId;
  final String diagnosis;
  final List<String> symptoms;
  final String type;
  final String treatment;
  final String notes;
  final List<String> attachments;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PatientInfo? patient;
  final DoctorInfo? doctor;

  MedicalRecord({
    this.id,
    required this.patientId,
    required this.diagnosis,
    required this.symptoms,
    required this.type,
    required this.treatment,
    required this.notes,
    required this.attachments,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.patient,
    this.doctor,
  });

  factory MedicalRecord.fromJson(Map<String, dynamic> json) {
    return MedicalRecord(
      id: json['_id'],
      patientId: json['patientId'] is String
          ? json['patientId']
          : json['patientId']['_id'],
      diagnosis: json['diagnosis'] ?? '',
      symptoms: List<String>.from(json['symptoms'] ?? []),
      type: json['type'] ?? '',
      treatment: json['treatment'] ?? '',
      notes: json['notes'] ?? '',
      attachments: List<String>.from(json['attachments'] ?? []),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      patient: json['patientId'] is Map<String, dynamic>
          ? PatientInfo.fromJson(json['patientId'])
          : null,
      doctor:
          json['doctorId'] != null && json['doctorId'] is Map<String, dynamic>
              ? DoctorInfo.fromJson(json['doctorId'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'diagnosis': diagnosis,
      'symptoms': symptoms,
      'type': type,
      'treatment': treatment,
      'notes': notes,
      'attachments': attachments,
    };
  }

  MedicalRecord copyWith({
    String? id,
    String? patientId,
    String? diagnosis,
    List<String>? symptoms,
    String? type,
    String? treatment,
    String? notes,
    List<String>? attachments,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
    PatientInfo? patient,
    DoctorInfo? doctor,
  }) {
    return MedicalRecord(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      diagnosis: diagnosis ?? this.diagnosis,
      symptoms: symptoms ?? this.symptoms,
      type: type ?? this.type,
      treatment: treatment ?? this.treatment,
      notes: notes ?? this.notes,
      attachments: attachments ?? this.attachments,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      patient: patient ?? this.patient,
      doctor: doctor ?? this.doctor,
    );
  }
}

class PatientInfo {
  final String id;
  final String name;
  final String email;

  PatientInfo({
    required this.id,
    required this.name,
    required this.email,
  });

  factory PatientInfo.fromJson(Map<String, dynamic> json) {
    return PatientInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}

class DoctorInfo {
  final String id;
  final String name;
  final String specialization;

  DoctorInfo({
    required this.id,
    required this.name,
    required this.specialization,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) {
    return DoctorInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }
}
