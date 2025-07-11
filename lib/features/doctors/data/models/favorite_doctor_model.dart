import 'doctor_model.dart';

class FavoriteDoctorModel {
  final String id;
  final String name;
  final String specialization;
  final double rating;
  final String? profileImage;
  final int? experience;
  final String? about;
  final bool isFavorite;

  FavoriteDoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.rating,
    this.profileImage,
    this.experience,
    this.about,
    this.isFavorite = true,
  });
  factory FavoriteDoctorModel.fromJson(Map<String, dynamic> json) {
    return FavoriteDoctorModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      specialization: json['specialization'] ?? '',
      profileImage: json['profileImage'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      experience: json['experience'],
      about: json['about'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'specialization': specialization,
      'profileImage': profileImage,
      'rating': rating,
      'experience': experience,
      'about': about,
    };
  }

  FavoriteDoctorModel copyWith({
    String? id,
    String? name,
    String? specialization,
    String? profileImage,
    double? rating,
    int? experience,
    String? about,
    bool? isFavorite,
  }) {
    return FavoriteDoctorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      specialization: specialization ?? this.specialization,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      experience: experience ?? this.experience,
      about: about ?? this.about,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  // Convert to DoctorModel if needed
  DoctorModel toDoctorModel() {
    return DoctorModel(
      id: id,
      name: name,
      specialty: specialization, // Map specialization to specialty
      profilePicture: profileImage ?? '',
      rating: rating,
      experienceYears: experience ?? 0,
      about: about ?? '',
      isFavorite: true,
      clinicName: '', // Default or empty value
      clinicAddress: '', // Default or empty value
      specialization: specialization, // Keep specialization for DoctorModel
    );
  }
}
