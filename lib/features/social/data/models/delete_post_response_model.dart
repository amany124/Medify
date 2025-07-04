class DeletePostsResponseModel {
  String? message;
  DeletedPost? deletedPost;

  DeletePostsResponseModel({this.message, this.deletedPost});

  DeletePostsResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    deletedPost = json['deletedPost'] != null
        ? new DeletedPost.fromJson(json['deletedPost'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.deletedPost != null) {
      data['deletedPost'] = this.deletedPost!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['content'] = this.content;
    return data;
  }
}