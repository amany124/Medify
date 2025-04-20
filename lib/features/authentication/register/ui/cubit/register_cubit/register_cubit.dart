import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/authentication/register/data/models/response_user_model.dart';
import 'package:medify/features/authentication/register/data/repo/register_repo.dart';

import '../../../../../../core/failures/failure.dart';
import '../../../data/models/doctor_model.dart';
import '../../../data/models/patient_model.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.registerRepo,
  ) : super(RegisterInitial());
  final RegisterRepo registerRepo;
  void registerDoctor({
    required DoctorModel doctorModel,
  }) async {
    emit(RegisterLoading());
    final result = await registerRepo.registerDoctor(doctorModel: doctorModel);
    return result.fold(
      (failure) => emit(RegisterFailure(failure)),
      (model) => emit(RegisterSuccess(
        model,
      )),
    );
  }

  void registerPatient({
    required PatientModel patientModel,
  }) async {
    emit(RegisterLoading());
    final result =
        await registerRepo.registerPatient(patientModel: patientModel);
    return result.fold(
      (failure) => emit(RegisterFailure(failure)),
      (model) => emit(RegisterSuccess(
        model,
      )),
    );
  }
}
