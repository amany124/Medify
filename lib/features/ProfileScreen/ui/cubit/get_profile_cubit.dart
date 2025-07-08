import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

import '../../../../core/failures/failure.dart';
import '../../data/repos/profile_repo.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  //name
  String name = '';
  GetProfileCubit(
    this.profileRepo,
  ) : super(GetProfileInitial());
  final ProfileRepo profileRepo;
  void getPatientProfile() async {
    emit(GetProfileLoading());
    final result = await profileRepo.getPatientProfile();

    return result.fold((failure) => emit(GetProfileFailure(failure)), (model) {
      emit(GetPatientProfileSuccess(patientModel: model));
      name = model.name;

      print('name: $name');
    });
  }

  void updatePatientProfile({required PatientModel patientModel}) async {
    emit(GetProfileLoading());
    final result = await profileRepo.updatePatientProfile(
      patientModel: patientModel,
    );
    return result.fold((failure) => emit(GetProfileFailure(failure)), (model) {
      name = model.name;
      emit(GetPatientProfileSuccess(patientModel: model));
      print('name: $name');
    });
  }

  //getDoctorProfile
  void getDoctorProfile() async {
    emit(GetProfileLoading());
    final result = await profileRepo.getDoctorProfile();
    return result.fold((failure) => emit(GetProfileFailure(failure)), (model) {
      name = model.name;
      emit(GetDoctorProfileSuccess(doctorModel: model));
      print('name: $name');
    });
  }

  //updateDoctorProfile
  void updateDoctorProfile({required DoctorModel doctorModel}) async {
    emit(GetProfileLoading());
    final result = await profileRepo.updateDoctorProfile(
      doctorModel: doctorModel,
    );
    return result.fold((failure) => emit(GetProfileFailure(failure)), (model) {
      name = model.name;
      emit(GetDoctorProfileSuccess(doctorModel: model));
      print('name: $name');
    });
  }
}
