import 'package:equatable/equatable.dart';
import 'package:medify/core/failures/failure.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_response.dart';

abstract class PredictDiseaseState extends Equatable {
  const PredictDiseaseState();

  @override
  List<Object?> get props => [];
}

class PredictDiseaseInitial extends PredictDiseaseState {}

class PredictDiseaseLoading extends PredictDiseaseState {}

class PredictDiseaseSuccess extends PredictDiseaseState {
  final HeartDiseasesResponse response;

  const PredictDiseaseSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class PredictDiseaseFailure extends PredictDiseaseState {
  final Failure failure;

  const PredictDiseaseFailure(this.failure);

  @override
  List<Object?> get props => [failure];
}
