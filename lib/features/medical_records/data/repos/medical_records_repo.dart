import 'package:dartz/dartz.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/features/medical_records/data/models/medical_record.dart';
import 'package:medify/features/medical_records/data/models/medical_records_response.dart';

abstract class MedicalRecordsRepo {
  Future<Either<Failure, MedicalRecord>> createMedicalRecord({
    required MedicalRecord medicalRecord,
  });

  Future<Either<Failure, MedicalRecordsResponse>> getMedicalRecords();
}
