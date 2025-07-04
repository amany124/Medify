part of 'doctors_cubit.dart';

abstract class DoctorsState extends Equatable {
  const DoctorsState();

  @override
  List<Object> get props => [];
}

class DoctorsInitial extends DoctorsState {}

class DoctorsLoading extends DoctorsState {}

class DoctorsLoaded extends DoctorsState {
  final List<DoctorModel> doctors;

  const DoctorsLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class DoctorsError extends DoctorsState {
  final String message;

  const DoctorsError({required this.message});

  @override
  List<Object> get props => [message];
}
