class GetPostsResponseModel {
  Doctor? doctor;
  List<Posts>? posts;

  GetPostsResponseModel({this.doctor, this.posts});

  GetPostsResponseModel.fromJson(Map<String, dynamic> json) {
    doctor =
        json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(new Posts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Posts {
  String? sId;
  String? content;
  int? likes;
  String? createdAt;
  String? doctorName;
  String? formattedDate;

  Posts(
      {this.sId,
      this.content,
      this.likes,
      this.createdAt,
      this.doctorName,
      this.formattedDate});

  Posts.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    likes = json['likes'];
    createdAt = json['createdAt'];
    doctorName = json['doctorName'];
    formattedDate = json['formattedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['likes'] = this.likes;
    data['createdAt'] = this.createdAt;
    data['doctorName'] = this.doctorName;
    data['formattedDate'] = this.formattedDate;
    return data;
  }
}
