class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final String specialization; // Added field
  final String profilePicture;
  final double rating;
  final int experienceYears;
  final String about;
  final bool isFavorite;
  final String clinicName;
  final String clinicAddress;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.specialization, // Added parameter
    required this.profilePicture,
    required this.rating,
    required this.experienceYears,
    required this.about,
    this.isFavorite = false,
    required this.clinicName,
    required this.clinicAddress,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      specialization: json['specialization'] ?? '', // Added
      profilePicture: json['profilePicture'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      experienceYears: json['experienceYears'] ?? 0,
      about: json['about'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
      clinicName: json['clinicName'] ?? '',
      clinicAddress: json['clinicAddress'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'specialty': specialty,
      'specialization': specialization, // Added
      'profilePicture': profilePicture,
      'rating': rating,
      'experienceYears': experienceYears,
      'about': about,
      'isFavorite': isFavorite,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
    };
  }

  DoctorModel copyWith({
    String? id,
    String? name,
    String? specialty,
    String? specialization, // Added
    String? profilePicture,
    double? rating,
    int? experienceYears,
    String? about,
    bool? isFavorite,
    String? clinicName,
    String? clinicAddress,
  }) {
    return DoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      specialization: specialization ?? this.specialization, // Added
      profilePicture: profilePicture ?? this.profilePicture,
      rating: rating ?? this.rating,
      experienceYears: experienceYears ?? this.experienceYears,
      about: about ?? this.about,
      isFavorite: isFavorite ?? this.isFavorite,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
    );
  }
}
