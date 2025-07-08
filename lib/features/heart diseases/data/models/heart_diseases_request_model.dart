class HeartDiseasesRequest {
  final double bmi;
  final String smoking;
  final String alcoholDrinking;
  final String stroke;
  final int physicalHealth;
  final int mentalHealth;
  final String diffWalking;
  final String sex;
  final String ageCategory;
  final String race;
  final String diabetic;
  final String physicalActivity;
  final String genHealth;
  final int sleepTime;
  final String asthma;
  final String kidneyDisease;
  final String skinCancer;

  HeartDiseasesRequest({
    required this.bmi,
    required this.smoking,
    required this.alcoholDrinking,
    required this.stroke,
    required this.physicalHealth,
    required this.mentalHealth,
    required this.diffWalking,
    required this.sex,
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
  //fromJson
  factory HeartDiseasesRequest.fromJson(Map<String, dynamic> json) {
    return HeartDiseasesRequest(
      bmi: json['bmi'],
      smoking: json['smoking'],
      alcoholDrinking: json['alcoholDrinking'],
      stroke: json['stroke'],
      physicalHealth: json['physicalHealth'],
      mentalHealth: json['mentalHealth'],
      diffWalking: json['diffWalking'],
      sex: json['sex'],
      ageCategory: json['ageCategory'],
      race: json['race'],
      diabetic: json['diabetic'],
      physicalActivity: json['physicalActivity'],
      genHealth: json['genHealth'],
      sleepTime: json['sleepTime'],
      asthma: json['asthma'],
      kidneyDisease: json['kidneyDisease'],
      skinCancer: json['skinCancer'],
    );
  }
  //toJson
  Map<String, dynamic> toJson() {
    return {
      'BMI': bmi,
      'Smoking': smoking,
      'AlcoholDrinking': alcoholDrinking,
      'Stroke': stroke,
      'PhysicalHealth': physicalHealth,
      'MentalHealth': mentalHealth,
      'DiffWalking': diffWalking,
      'Sex': sex,
      'AgeCategory': ageCategory,
      'Race': race,
      'Diabetic': diabetic,
      'PhysicalActivity': physicalActivity,
      'GenHealth': genHealth,
      'SleepTime': sleepTime,
      'Asthma': asthma,
      'KidneyDisease': kidneyDisease,
      'SkinCancer': skinCancer,
    };
  }
}
