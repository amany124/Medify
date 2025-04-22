 class ResponseUserModel {
  final String id;
  final String name;
  final String email;
  final String role;

  ResponseUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
  factory ResponseUserModel.fromJson(Map<String, dynamic> json) {
    return ResponseUserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }
}
