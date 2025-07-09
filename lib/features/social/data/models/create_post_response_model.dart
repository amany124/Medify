class CreatePostResponseModel {
  String? doctorId;
  String? content;
  int? likes;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreatePostResponseModel(
      {this.doctorId,
      this.content,
      this.likes,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreatePostResponseModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorId'];
    content = json['content'];
    likes = json['likes'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['doctorId'] = doctorId;
    data['content'] = content;
    data['likes'] = likes;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
