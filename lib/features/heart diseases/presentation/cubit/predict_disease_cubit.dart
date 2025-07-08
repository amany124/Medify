import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_request_model.dart';
import 'package:medify/features/heart%20diseases/data/repos/predict_disease_repo.dart';
import 'package:medify/features/heart%20diseases/presentation/cubit/predict_disease_state.dart';

class PredictDiseaseCubit extends Cubit<PredictDiseaseState> {
  final PredictDiseaseRepo _predictDiseaseRepo;
  late HeartDiseasesRequest request;

  PredictDiseaseCubit(this._predictDiseaseRepo)
      : super(PredictDiseaseInitial());

  // Set the HeartDiseasesRequest from UI or external call
  void setRequest(HeartDiseasesRequest newRequest) {
    request = newRequest;
  }

  Future<void> predictHeartDisease() async {
    emit(PredictDiseaseLoading());

    final result = await _predictDiseaseRepo.predictDisease(request: request);
    print(result.toString());

    result.fold(
      (failure) => emit(PredictDiseaseFailure(failure)),
      (response) => emit(PredictDiseaseSuccess(response)),
    );
  }

  // Reset cubit state to initial
  void resetState() {
    emit(PredictDiseaseInitial());
  }
}
