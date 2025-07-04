import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/favorite_doctor_model.dart';
import '../../data/repos/favorite_doctors_repo.dart';

part 'favorite_doctors_state.dart';

class FavoriteDoctorsCubit extends Cubit<FavoriteDoctorsState> {
  final FavoriteDoctorsRepo _favoriteDoctorsRepo;

  FavoriteDoctorsCubit({
    required FavoriteDoctorsRepo favoriteDoctorsRepo,
  })  : _favoriteDoctorsRepo = favoriteDoctorsRepo,
        super(FavoriteDoctorsInitial());

  Future<void> getFavoriteDoctors() async {
    emit(FavoriteDoctorsLoading());

    final result = await _favoriteDoctorsRepo.getFavoriteDoctors();

    result.fold(
      (failure) => emit(FavoriteDoctorsError(message: failure.message)),
      (doctors) {
        // Sort doctors by rating in descending order
        final sortedDoctors = List<FavoriteDoctorModel>.from(doctors)
          ..sort((a, b) => b.rating.compareTo(a.rating));
        emit(FavoriteDoctorsLoaded(doctors: sortedDoctors));
      },
    );
  }

  Future<void> addDoctorToFavorites(String doctorId) async {
    emit(FavoriteActionLoading());

    final result =
        await _favoriteDoctorsRepo.addDoctorToFavorites(doctorId: doctorId);

    result.fold(
      (failure) => emit(FavoriteActionError(message: failure.message)),
      (success) {
        // After successfully adding, refresh favorite doctors list
        getFavoriteDoctors();
        emit(const FavoriteActionSuccess(message: 'Doctor added to favorites'));
      },
    );
  }

  Future<void> removeDoctorFromFavorites(String doctorId) async {
    emit(FavoriteActionLoading());

    final result = await _favoriteDoctorsRepo.removeDoctorFromFavorites(
        doctorId: doctorId);

    result.fold(
      (failure) => emit(FavoriteActionError(message: failure.message)),
      (success) {
        // After successfully removing, refresh favorite doctors list
        getFavoriteDoctors();
        emit(const FavoriteActionSuccess(
            message: 'Doctor removed from favorites'));
      },
    );
  }
}
