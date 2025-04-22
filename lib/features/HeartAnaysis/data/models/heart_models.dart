class HeartAnalysisResultModel {
  final String predictedClass;
  final String heatmapImageBase64;

  HeartAnalysisResultModel({
    required this.predictedClass,
    required this.heatmapImageBase64,
  });

  factory HeartAnalysisResultModel.fromJson(Map<String, dynamic> json) {
    return HeartAnalysisResultModel(
      predictedClass: json['predicted_class'],
      heatmapImageBase64: json['heatmap_image_base64'],
    );
  }
}
