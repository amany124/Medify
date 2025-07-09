class UpdatePostResponseModel {
  String? message;
  Post? post;

  UpdatePostResponseModel({this.message, this.post});

  UpdatePostResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (post != null) {
      data['post'] = post!.toJson();
    }
    return data;
  }
}

class Post {
  String? sId;
  String? doctorId;
  String? content;
  int? likes;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? doctorName;
  String? formattedDate;

  Post(
      {this.sId,
      this.doctorId,
      this.content,
      this.likes,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.doctorName,
      this.formattedDate});

  Post.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    doctorId = json['doctorId'];
    content = json['content'];
    likes = json['likes'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    doctorName = json['doctorName'];
    formattedDate = json['formattedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['doctorId'] = doctorId;
    data['content'] = content;
    data['likes'] = likes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['doctorName'] = doctorName;
    data['formattedDate'] = formattedDate;
    return data;
  }
}
