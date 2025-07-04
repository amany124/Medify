class UpdatePostResponseModel {
  String? message;
  Post? post;

  UpdatePostResponseModel({this.message, this.post});

  UpdatePostResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['doctorId'] = this.doctorId;
    data['content'] = this.content;
    data['likes'] = this.likes;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['doctorName'] = this.doctorName;
    data['formattedDate'] = this.formattedDate;
    return data;
  }
}
