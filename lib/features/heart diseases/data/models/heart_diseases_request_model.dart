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
      'bmi': bmi,
      'smoking': smoking,
      'alcoholDrinking': alcoholDrinking,
      'stroke': stroke,
      'physicalHealth': physicalHealth,
      'mentalHealth': mentalHealth,
      'diffWalking': diffWalking,
      'sex': sex,
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
}
