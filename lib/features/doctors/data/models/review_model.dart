class ReviewModel {
  final String? id;
  final String doctorId;
  final String patientId;
  final double rating;
  final String comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ReviewModel({
    this.id,
    required this.doctorId,
    required this.patientId,
    required this.rating,
    required this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'],
      doctorId: json['doctorId'],
      patientId: json['patientId'],
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'rating': rating,
      'comment': comment,
    };
  }
}
