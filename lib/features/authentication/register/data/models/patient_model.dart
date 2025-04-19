class PatientModel {
<<<<<<< HEAD
  String id;
  String name;
  String email;
  String username;
  String? password;
  String? role;
=======
  String name;
  String email;
  String username;
  String password;
  String role;
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
  String gender;
  String dateOfBirth;
  String bloodType;
  int height;
  int weight;
<<<<<<< HEAD
  String? chronicCondition;
=======
  String chronicCondition;
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
  bool diabetes;
  int heartRate;

  PatientModel({
    required this.name,
    required this.email,
    required this.username,
<<<<<<< HEAD
    this.password,
    this.role,
=======
    required this.password,
    required this.role,
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
    required this.gender,
    required this.dateOfBirth,
    required this.bloodType,
    required this.height,
    required this.weight,
<<<<<<< HEAD
    this.chronicCondition,
    required this.diabetes,
    required this.heartRate,
    required this.id,
=======
    required this.chronicCondition,
    required this.diabetes,
    required this.heartRate,
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
  });

  // Factory constructor to create a PatientModel from a JSON map
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
<<<<<<< HEAD
      id: json['_id'],
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'],
<<<<<<< HEAD
      role: json['role'] ?? '',
=======
      role: json['role'],
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      bloodType: json['bloodType'],
      height: json['height'],
      weight: json['weight'],
<<<<<<< HEAD
      chronicCondition: json['chronicCondition'] ?? '',
=======
      chronicCondition: json['chronicCondition'],
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
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
<<<<<<< HEAD
      id: id, // ID should not be changed
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
    );
  }
}
