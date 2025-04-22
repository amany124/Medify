import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:medify/features/HeartAnaysis/data/models/heart_models.dart';
import 'package:medify/features/HeartAnaysis/data/repo/heart_repo.dart';


part 'heart_analysis_state.dart';

class HeartAnalysisCubit extends Cubit<HeartAnalysisState> {
  final HeartAnalysisRepo repo;

  HeartAnalysisCubit(this.repo) : super(HeartAnalysisInitial());

  Future<void> analyzeImage(File imageFile) async {
    emit(HeartAnalysisLoading());

    final result = await repo.analyzeImage(imageFile);

    result.fold(
      (error) => emit(HeartAnalysisError(error)),
      (data) => emit(HeartAnalysisSuccess(data)),
    );
  }
}
