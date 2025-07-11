class GetPostsResponseModel {
  Doctor? doctor;
  List<Posts>? posts;

  GetPostsResponseModel({this.doctor, this.posts});

  GetPostsResponseModel.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (doctor != null) {
      data['doctor'] = doctor!.toJson();
    }
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Doctor {
  String? sId;
  String? name;

  Doctor({this.sId, this.name});

  Doctor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

class Posts {
  String? sId;
  String? content;
  String? image;
  int? likes;
  String? createdAt;
  String? doctorName;
  String? formattedDate;
  String? doctorProfilePicture;

  Posts({
    this.sId,
    this.content,
    this.image,
    this.likes,
    this.createdAt,
    this.doctorName,
    this.formattedDate,
    this.doctorProfilePicture,
  });

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    image = json['image'];
    likes = json['likes'];
    createdAt = json['createdAt'];
    doctorName = json['doctorName'];
    formattedDate = json['formattedDate'];
    doctorProfilePicture = json['doctorProfilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    if (image != null) {
      data['image'] = image;
    }
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    data['doctorName'] = doctorName;
    data['formattedDate'] = formattedDate;
    data['doctorProfilePicture'] = doctorProfilePicture;
    return data;
  }
}
