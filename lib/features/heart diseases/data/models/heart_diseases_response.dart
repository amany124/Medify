class HeartDiseasesResponse {
  //diagnosis
  //probability
  final String diagnosis;
  final double probability;
  const HeartDiseasesResponse({
    required this.diagnosis,
    required this.probability,
  });
  //fromJson
  factory HeartDiseasesResponse.fromJson(Map<String, dynamic> json) {
    return HeartDiseasesResponse(
      diagnosis: json['diagnosis'] ?? '',
      probability: (json['probability'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
