part of 'heart_analysis_cubit.dart';

abstract class HeartAnalysisState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HeartAnalysisInitial extends HeartAnalysisState {}

class HeartAnalysisLoading extends HeartAnalysisState {}

class HeartAnalysisSuccess extends HeartAnalysisState {
  final HeartAnalysisResultModel result;

  HeartAnalysisSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class HeartAnalysisError extends HeartAnalysisState {
  final String message;

  HeartAnalysisError(this.message);

  @override
  List<Object?> get props => [message];
}
