// TODO: token , content, image

class CreatePostRequestModel {
  final String token;
  final String content;
  final String? image; // Optional field for image

  CreatePostRequestModel({
    required this.token,
    required this.content,
    this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'content': content,
      // 'image': image, // Include image if provided
    };
  }
}
