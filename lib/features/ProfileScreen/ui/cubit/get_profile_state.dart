part of 'get_profile_cubit.dart';

abstract class GetProfileState {}

class GetProfileInitial extends GetProfileState {}

class GetProfileLoading extends GetProfileState {}

class GetProfileFailure extends GetProfileState {
  final Failure failure;
  GetProfileFailure(this.failure);
}

class GetPatientProfileSuccess extends GetProfileState {
  final PatientModel? patientModel;
  GetPatientProfileSuccess({this.patientModel,});
}
class GetDoctorProfileSuccess extends GetProfileState {
  final DoctorModel? doctorModel;
  GetDoctorProfileSuccess({this.doctorModel});
}
