class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String profileImage;
  final double rating;
  final int experience;
  final String about;
  final bool isFavorite;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.profileImage,
    required this.rating,
    required this.experience,
    required this.about,
    this.isFavorite = false,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      profileImage: json['profileImage'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      experience: json['experience'] ?? 0,
      about: json['about'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'specialty': specialty,
      'profileImage': profileImage,
      'rating': rating,
      'experience': experience,
      'about': about,
      'isFavorite': isFavorite,
    };
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialty,
    String? profileImage,
    double? rating,
    int? experience,
    String? about,
    bool? isFavorite,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
