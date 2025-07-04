part of 'doctor_public_profile_cubit.dart';

abstract class DoctorPublicProfileState extends Equatable {
  const DoctorPublicProfileState();

  @override
  List<Object> get props => [];
}

class DoctorPublicProfileInitial extends DoctorPublicProfileState {}

class DoctorPublicProfileLoading extends DoctorPublicProfileState {}

class DoctorPublicProfileLoaded extends DoctorPublicProfileState {
  final DoctorPublicProfileModel profile;

  const DoctorPublicProfileLoaded(this.profile);

  @override
  List<Object> get props => [profile];
}

class DoctorPublicProfileError extends DoctorPublicProfileState {
  final String message;

  const DoctorPublicProfileError(this.message);

  @override
  List<Object> get props => [message];
}
