import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/medical_records/data/models/medical_record.dart';
import 'package:medify/features/medical_records/data/repos/medical_records_repo.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_state.dart';

class MedicalRecordsCubit extends Cubit<MedicalRecordsState> {
  final MedicalRecordsRepo medicalRecordsRepo;

  MedicalRecordsCubit({required this.medicalRecordsRepo})
      : super(MedicalRecordsInitial()) {
    log('MedicalRecordsCubit: New instance created');
  }

  Future<void> createMedicalRecord({
    required MedicalRecord medicalRecord,
  }) async {
    log('MedicalRecordsCubit: createMedicalRecord called');
    if (isClosed) {
      log('MedicalRecordsCubit: Cubit is closed, returning');
      return;
    }

    log('MedicalRecordsCubit: Emitting loading state');
    emit(MedicalRecordsLoading());

    try {
      log('MedicalRecordsCubit: Calling repository to create medical record');
      final result = await medicalRecordsRepo.createMedicalRecord(
        medicalRecord: medicalRecord,
      );

      if (isClosed) {
        log('MedicalRecordsCubit: Cubit is closed after API call, returning');
        return;
      }

      log('MedicalRecordsCubit: API call completed, processing result');
      result.fold(
        (failure) {
          log('MedicalRecordsCubit: API call failed with error: ${failure.message}');
          if (!isClosed) emit(MedicalRecordsError(failure.message));
        },
        (record) {
          log('MedicalRecordsCubit: API call successful, emitting success state');
          if (!isClosed) emit(MedicalRecordCreated(record));
        },
      );
    } catch (e) {
      log('MedicalRecordsCubit: Exception occurred: $e');
      if (!isClosed) emit(MedicalRecordsError(e.toString()));
    }
  }

  Future<void> getMedicalRecords() async {
    if (isClosed) return;

    emit(MedicalRecordsLoading());

    try {
      final result = await medicalRecordsRepo.getMedicalRecords();

      if (isClosed) return;

      result.fold(
        (failure) {
          if (!isClosed) emit(MedicalRecordsError(failure.message));
        },
        (records) {
          if (!isClosed) emit(MedicalRecordsLoaded(records));
        },
      );
    } catch (e) {
      if (!isClosed) emit(MedicalRecordsError(e.toString()));
    }
  }
}
