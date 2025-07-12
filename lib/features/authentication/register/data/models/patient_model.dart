import '../../../../heart diseases/data/models/heart_diseases_request_model.dart';

class PatientModel {
  String name;
  String email;
  String username;
  String password;
  String role;
  String gender;
  String dateOfBirth;
  String bloodType;

  // Old fields - keeping for compatibility
  int? height;
  int? weight;
  String? chronicCondition;
  int heartRate;

  // New health-related fields
  double bmi;
  bool smoking;
  bool alcoholDrinking;
  bool stroke;
  int physicalHealth;
  int mentalHealth;
  bool diffWalking;
  String ageCategory;
  String race;
  String diabetic;
  bool physicalActivity;
  String genHealth;
  int sleepTime;
  bool asthma;
  bool kidneyDisease;
  bool skinCancer;

  PatientModel({
    required this.name,
    required this.email,
    required this.username,
    required this.password,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.bloodType,

    // Old fields
    this.height,
    this.weight,
    this.chronicCondition,
    required this.heartRate,

    // New fields
    required this.bmi,
    this.smoking = false,
    this.alcoholDrinking = false,
    this.stroke = false,
    required this.physicalHealth,
    required this.mentalHealth,
    required this.diffWalking,
    required this.ageCategory,
    required this.race,
    required this.diabetic,
    required this.physicalActivity,
    required this.genHealth,
    required this.sleepTime,
    required this.asthma,
    required this.kidneyDisease,
    required this.skinCancer,
  });

  // Factory constructor to create a PatientModel from a JSON map
  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      email: json['email'],
      username: json['username'],
      password: json['password'] ?? '',
      role: json['role'] ?? '',
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      bloodType: json['bloodType'],
      // Old fields

      heartRate: json['heartRate'] ?? 0,
      // New fields
      bmi: (json['bmi'] ?? 0.0).toDouble(),
      smoking: json['smoking'] ?? false,
      alcoholDrinking: json['alcoholDrinking'] ?? false,
      stroke: json['stroke'] ?? false,
      physicalHealth: json['physicalHealth'] ?? 0,
      mentalHealth: json['mentalHealth'] ?? 0,
      diffWalking: json['diffWalking'] ?? false,
      ageCategory: json['ageCategory'] ?? '',
      race: json['race'] ?? '',
      diabetic: json['diabetic'] ?? 'No',
      physicalActivity: json['physicalActivity'] ?? false,
      genHealth: json['genHealth'] ?? '',
      sleepTime: json['sleepTime'] ?? 0,
      asthma: json['asthma'] ?? false,
      kidneyDisease: json['kidneyDisease'] ?? false,
      skinCancer: json['skinCancer'] ?? false,
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

      // Old fields
      'height': height,
      'weight': weight,
      'chronicCondition': chronicCondition,
      'heartRate': heartRate,

      // New fields
      'bmi': bmi,
      'smoking': smoking,
      'alcoholDrinking': alcoholDrinking,
      'stroke': stroke,
      'physicalHealth': physicalHealth,
      'mentalHealth': mentalHealth,
      'diffWalking': diffWalking,
      'ageCategory': ageCategory,
      'race': race,
      'diabetic': diabetic,
      'physicalActivity': physicalActivity,
      'genHealth': genHealth,
      'sleepTime': sleepTime,
      'asthma': asthma,
      'kidneyDisease': kidneyDisease,
      'skinCancer': skinCancer,
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

    // Old fields
    int? height,
    int? weight,
    String? chronicCondition,
    bool? diabetes,
    int? heartRate,

    // New fields
    double? bmi,
    bool? smoking,
    bool? alcoholDrinking,
    bool? stroke,
    int? physicalHealth,
    int? mentalHealth,
    bool? diffWalking,
    String? ageCategory,
    String? race,
    String? diabetic,
    bool? physicalActivity,
    String? genHealth,
    int? sleepTime,
    bool? asthma,
    bool? kidneyDisease,
    bool? skinCancer,
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

      // Old fields
      height: height ?? this.height,
      weight: weight ?? this.weight,
      chronicCondition: chronicCondition ?? this.chronicCondition,
      heartRate: heartRate ?? this.heartRate,

      // New fields
      bmi: bmi ?? this.bmi,
      smoking: smoking ?? this.smoking,
      alcoholDrinking: alcoholDrinking ?? this.alcoholDrinking,
      stroke: stroke ?? this.stroke,
      physicalHealth: physicalHealth ?? this.physicalHealth,
      mentalHealth: mentalHealth ?? this.mentalHealth,
      diffWalking: diffWalking ?? this.diffWalking,
      ageCategory: ageCategory ?? this.ageCategory,
      race: race ?? this.race,
      diabetic: diabetic ?? this.diabetic,
      physicalActivity: physicalActivity ?? this.physicalActivity,
      genHealth: genHealth ?? this.genHealth,
      sleepTime: sleepTime ?? this.sleepTime,
      asthma: asthma ?? this.asthma,
      kidneyDisease: kidneyDisease ?? this.kidneyDisease,
      skinCancer: skinCancer ?? this.skinCancer,
    );
  }

  HeartDiseasesRequest toHeartDiseasesRequest() {
    return HeartDiseasesRequest(
      bmi: bmi,
      smoking: toStringBool(smoking),
      alcoholDrinking: toStringBool(alcoholDrinking),
      stroke: toStringBool(stroke),
      physicalHealth: physicalHealth,
      mentalHealth: mentalHealth,
      diffWalking: toStringBool(diffWalking),
      sex: gender,
      ageCategory: ageCategory,
      race: race,
      diabetic: diabetic,
      physicalActivity: toStringBool(physicalActivity),
      genHealth: genHealth,
      sleepTime: sleepTime,
      asthma: toStringBool(asthma),
      kidneyDisease: toStringBool(kidneyDisease),
      skinCancer: toStringBool(skinCancer),
    );
  }

////toStringBool
  toStringBool(bool boolVar) {
    if (boolVar == false) {
      return 'No';
    } else {
      return 'Yes';
    }
  }
}
