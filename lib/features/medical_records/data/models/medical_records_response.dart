import 'medical_record.dart';

class MedicalRecordsResponse {
  final bool success;
  final int count;
  final List<MedicalRecord> data;
  final MedicalRecordsDebug debug;

  MedicalRecordsResponse({
    required this.success,
    required this.count,
    required this.data,
    required this.debug,
  });

  factory MedicalRecordsResponse.fromJson(Map<String, dynamic> json) {
    return MedicalRecordsResponse(
      success: json['success'] ?? false,
      count: json['count'] ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((item) => MedicalRecord.fromJson(item))
          .toList(),
      debug: MedicalRecordsDebug.fromJson(json['debug'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'count': count,
      'data': data.map((record) => record.toJson()).toList(),
      'debug': debug.toJson(),
    };
  }
}

class MedicalRecordsDebug {
  final String userId;
  final bool isDoctor;
  final Map<String, dynamic> query;

  MedicalRecordsDebug({
    required this.userId,
    required this.isDoctor,
    required this.query,
  });

  factory MedicalRecordsDebug.fromJson(Map<String, dynamic> json) {
    return MedicalRecordsDebug(
      userId: json['userId'] ?? '',
      isDoctor: json['isDoctor'] ?? false,
      query: json['query'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'isDoctor': isDoctor,
      'query': query,
    };
  }
}
