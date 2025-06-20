

class UpdatePostsRequestModel {
  final String token;
  final String postId; // ID of the doctor whose posts you want to retrieve
  final String content;

  UpdatePostsRequestModel({
    required this.token,
    required this.postId,
    required this.content,
  
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'doctorId': postId,
      'content': content,
     
    };
  }
}
