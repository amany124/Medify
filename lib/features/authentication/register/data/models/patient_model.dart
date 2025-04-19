class PatientModel {
  String id;
  String name;
  String email;
  String username;
  String? password;
  String? role;
  String gender;
  String dateOfBirth;
  String bloodType;
  int height;
  int weight;
  String? chronicCondition;
  bool diabetes;
  int heartRate;

  PatientModel({
    required this.name,
    required this.email,
    required this.username,
    this.password,
    this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.bloodType,
    required this.height,
    required this.weight,
    this.chronicCondition,
    required this.diabetes,
    required this.heartRate,
    required this.id,
  });

  // Factory constructor to create a PatientModel from a JSON map
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['_id'],
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
      role: json['role'] ?? '',
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      bloodType: json['bloodType'],
      height: json['height'],
      weight: json['weight'],
      chronicCondition: json['chronicCondition'] ?? '',
      diabetes: json['diabetes'],
      heartRate: json['heartRate'],
    );
  }

  // Method to convert a PatientModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'role': role,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'bloodType': bloodType,
      'height': height,
      'weight': weight,
      'chronicCondition': chronicCondition,
      'diabetes': diabetes,
      'heartRate': heartRate,
    };
  }

  // copyWith method to create a new PatientModel instance with updated values
  PatientModel copyWith({
    String? name,
    String? email,
    String? username,
    String? password,
    String? role,
    String? gender,
    String? dateOfBirth,
    String? bloodType,
    int? height,
    int? weight,
    String? chronicCondition,
    bool? diabetes,
    int? heartRate,
  }) {
    return PatientModel(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bloodType: bloodType ?? this.bloodType,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      chronicCondition: chronicCondition ?? this.chronicCondition,
      diabetes: diabetes ?? this.diabetes,
      heartRate: heartRate ?? this.heartRate,
      id: id, // ID should not be changed
    );
  }
}
