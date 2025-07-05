import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:medify/features/HeartAnaysis/data/models/heart_models.dart';

class HeartAnalysisRepo {
  final Dio dio;

  HeartAnalysisRepo(this.dio);

  Future<Either<String, HeartAnalysisResultModel>> analyzeImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path, filename: 'image.jpg'),
      });

      final response = await dio.post(
        'https://foly884-foly.hf.space/predict',
        data: formData,
      );

      return Right(HeartAnalysisResultModel.fromJson(response.data));
    } catch (e) {
      return Left("Failed to analyze image: $e");
    }
  }
}
