part of 'favorite_doctors_cubit.dart';

abstract class FavoriteDoctorsState extends Equatable {
  const FavoriteDoctorsState();

  @override
  List<Object> get props => [];
}

class FavoriteDoctorsInitial extends FavoriteDoctorsState {}

class FavoriteDoctorsLoading extends FavoriteDoctorsState {}

class FavoriteDoctorsLoaded extends FavoriteDoctorsState {
  final List<FavoriteDoctorModel> doctors;

  const FavoriteDoctorsLoaded({required this.doctors});

  @override
  List<Object> get props => [doctors];
}

class FavoriteDoctorsError extends FavoriteDoctorsState {
  final String message;

  const FavoriteDoctorsError({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteActionLoading extends FavoriteDoctorsState {}

class FavoriteActionSuccess extends FavoriteDoctorsState {
  final String message;
  
  const FavoriteActionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class FavoriteActionError extends FavoriteDoctorsState {
  final String message;

  const FavoriteActionError({required this.message});

  @override
  List<Object> get props => [message];
}
