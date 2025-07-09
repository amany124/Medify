class ProfilePictureResponse {
  final String message;
  final String profilePicture;

  ProfilePictureResponse({
    required this.message,
    required this.profilePicture,
  });

  factory ProfilePictureResponse.fromJson(Map<String, dynamic> json) {
    return ProfilePictureResponse(
      message: json['message'] as String,
      profilePicture: json['profilePicture'] as String,
    );
  }
}
