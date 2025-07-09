class VerificationImageResponse {
  final String message;
  final String verificationImage;

  VerificationImageResponse({
    required this.message,
    required this.verificationImage,
  });

  factory VerificationImageResponse.fromJson(Map<String, dynamic> json) {
    return VerificationImageResponse(
      message: json['message'] as String,
      verificationImage: json['verificationImage'] as String,
    );
  }
}