class DoctorModel {
  String name;
  String email;
  String username;
  String password;
  String? role;
  String gender;
  String nationality;
  String phone;
  String clinicName;
  String clinicAddress;
  String specialization;
  int experienceYears;

  DoctorModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    this.role,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.clinicName,
    required this.clinicAddress,
    required this.specialization,
    required this.experienceYears,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> map) {
    return DoctorModel(
      name: map['name'],
      email: map['email'],
      username: map['username'],
      password: map['password'],
      role: map['role'] ?? '',
      gender: map['gender'],
      nationality: map['nationality'],
      phone: map['phone'] ?? '01012221258',
      clinicName: map['clinicName'],
      clinicAddress: map['clinicAddress'],
      specialization: map['specialization'],
      experienceYears: map['experienceYears'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'password': password,
      'role': role,
      'gender': gender,
      'nationality': nationality,
      'phone': phone,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'specialization': specialization,
      'experienceYears': experienceYears,
    };
  }

  DoctorModel copyWith({
    String? name,
    String? email,
    String? username,
    String? password,
    String? role,
    String? gender,
    String? nationality,
    String? phone,
    String? clinicName,
    String? clinicAddress,
    String? specialization,
    int? experienceYears,
  }) {
    return DoctorModel(
      name: name ?? this.name,
      email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      phone: phone ?? this.phone,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      specialization: specialization ?? this.specialization,
      experienceYears: experienceYears ?? this.experienceYears,
    );
  }
}
