import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/features/authentication/register/data/models/user_model.dart';
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
      (responseModel) {
        LocalData.setAuthResponseModel(responseModel);
        emit(RegisterSuccess(responseModel.user));
      },
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
      (responseModel) {
        LocalData.setAuthResponseModel(responseModel);
        LocalData.setIsLogin(true);
        emit(RegisterSuccess(responseModel.user));
      },
    );
  }
}
