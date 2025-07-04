import 'package:equatable/equatable.dart';

class DoctorPublicProfileModel extends Equatable {
  final DoctorProfileData doctor;
  final List<DoctorPost> posts;

  const DoctorPublicProfileModel({
    required this.doctor,
    required this.posts,
  });

  factory DoctorPublicProfileModel.fromJson(Map<String, dynamic> json) {
    return DoctorPublicProfileModel(
      doctor: DoctorProfileData.fromJson(json['doctor']),
      posts: (json['posts'] as List)
          .map((post) => DoctorPost.fromJson(post))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [doctor, posts];
}

class DoctorProfileData extends Equatable {
  final String id;
  final String name;

  const DoctorProfileData({
    required this.id,
    required this.name,
  });

  factory DoctorProfileData.fromJson(Map<String, dynamic> json) {
    return DoctorProfileData(
      id: json['_id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}

class DoctorPost extends Equatable {
  final String id;
  final String content;
  final String? image;
  final int likes;
  final String createdAt;
  final String doctorName;
  final String formattedDate;

  const DoctorPost({
    required this.id,
    required this.content,
    this.image,
    required this.likes,
    required this.createdAt,
    required this.doctorName,
    required this.formattedDate,
  });

  factory DoctorPost.fromJson(Map<String, dynamic> json) {
    return DoctorPost(
      id: json['_id'],
      content: json['content'],
      image: json['image'],
      likes: json['likes'] ?? 0,
      createdAt: json['createdAt'],
      doctorName: json['doctorName'],
      formattedDate: json['formattedDate'],
    );
  }

  @override
  List<Object?> get props =>
      [id, content, image, likes, createdAt, doctorName, formattedDate];
}
