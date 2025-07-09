class DeletePostsResponseModel {
  String? message;
  DeletedPost? deletedPost;

  DeletePostsResponseModel({this.message, this.deletedPost});

  DeletePostsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    deletedPost = json['deletedPost'] != null
        ? DeletedPost.fromJson(json['deletedPost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (deletedPost != null) {
      data['deletedPost'] = deletedPost!.toJson();
    }
    return data;
  }
}

class DeletedPost {
  String? id;
  String? content;

  DeletedPost({this.id, this.content});

  DeletedPost.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['content'] = content;
    return data;
  }
}
