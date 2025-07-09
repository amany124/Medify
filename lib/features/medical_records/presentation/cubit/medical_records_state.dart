import 'package:medify/features/medical_records/data/models/medical_record.dart';

import '../../data/models/medical_records_response.dart';

abstract class MedicalRecordsState {}

class MedicalRecordsInitial extends MedicalRecordsState {}

class MedicalRecordsLoading extends MedicalRecordsState {}

class MedicalRecordsLoaded extends MedicalRecordsState {
  final MedicalRecordsResponse records;

  MedicalRecordsLoaded(this.records);
}

class MedicalRecordCreated extends MedicalRecordsState {
  final MedicalRecord record;

  MedicalRecordCreated(this.record);
}

class MedicalRecordsError extends MedicalRecordsState {
  final String message;

  MedicalRecordsError(this.message);
}
