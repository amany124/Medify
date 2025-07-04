class RequestResetPasswordModel {
  final String email;
  final String role;

  RequestResetPasswordModel({
    required this.email,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
    };
  }
}

class ResetPasswordModel {
  final String email;
  final String role;
  final String otp;
  final String newPassword;

  ResetPasswordModel({
    required this.email,
    required this.role,
    required this.otp,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'role': role,
      'otp': otp,
      'newPassword': newPassword,
    };
  }
}
