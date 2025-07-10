import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

/// Mixin to manage all text controllers for the profile screen
mixin ProfileControllersMixin {
  // Common controllers
  final TextEditingController username = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  // Patient-specific controllers
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController physicalHealthController =
      TextEditingController();
  final TextEditingController mentalHealthController = TextEditingController();
  final TextEditingController ageCategoryController = TextEditingController();
  final TextEditingController raceController = TextEditingController();
  final TextEditingController diabeticController = TextEditingController();
  final TextEditingController genHealthController = TextEditingController();
  final TextEditingController sleepTimeController = TextEditingController();
  final TextEditingController physicalActivityController =
      TextEditingController();
  final TextEditingController diffWalkingController = TextEditingController();
  final TextEditingController asthmaController = TextEditingController();
  final TextEditingController kidneyDiseaseController = TextEditingController();
  final TextEditingController skinCancerController = TextEditingController();

  // Old fields controllers
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController chronicController = TextEditingController();
  final TextEditingController diabetesController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();
  final TextEditingController smokingController = TextEditingController();
  final TextEditingController alcoholDrinkingController =
      TextEditingController();
  final TextEditingController strokeController = TextEditingController();

  // Doctor-specific controllers
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController specializationController =
      TextEditingController();
  final TextEditingController experienceYearsController =
      TextEditingController();
  final TextEditingController ratingController = TextEditingController();

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  /// Populate patient data into controllers
  void populatePatientControllers(PatientModel patient) {
    username.text = patient.username;
    fullNameController.text = patient.name;
    emailController.text = patient.email;
    genderController.text = patient.gender;
    bloodTypeController.text = patient.bloodType;
    bmiController.text = patient.bmi.toString();
    physicalHealthController.text = patient.physicalHealth.toString();
    mentalHealthController.text = patient.mentalHealth.toString();
    ageCategoryController.text = patient.ageCategory;
    raceController.text = patient.race;
    diabeticController.text = patient.diabetic;
    genHealthController.text = patient.genHealth;
    sleepTimeController.text = patient.sleepTime.toString();
    physicalActivityController.text = patient.physicalActivity ? 'Yes' : 'No';
    diffWalkingController.text = patient.diffWalking ? 'Yes' : 'No';
    asthmaController.text = patient.asthma ? 'Yes' : 'No';
    kidneyDiseaseController.text = patient.kidneyDisease ? 'Yes' : 'No';
    skinCancerController.text = patient.skinCancer ? 'Yes' : 'No';

    // Old fields
    heightController.text = patient.height.toString();
    weightController.text = patient.weight.toString();
    chronicController.text = patient.chronicCondition ?? '';
    heartRateController.text = patient.heartRate.toString();
    smokingController.text = patient.smoking ? 'Yes' : 'No';
    alcoholDrinkingController.text = patient.alcoholDrinking ? 'Yes' : 'No';
    strokeController.text = patient.stroke ? 'Yes' : 'No';
    dobController.text =
        _dateFormatter.format(DateTime.parse(patient.dateOfBirth));
  }

  /// Populate doctor data into controllers
  void populateDoctorControllers(DoctorModel doctor) {
    username.text = doctor.username;
    fullNameController.text = doctor.name;
    emailController.text = doctor.email;
    genderController.text = doctor.gender;
    phoneController.text = doctor.phone;
    nationalityController.text = doctor.nationality;
    clinicNameController.text = doctor.clinicName;
    clinicAddressController.text = doctor.clinicAddress;
    specializationController.text = doctor.specialization;
    experienceYearsController.text = doctor.experienceYears.toString();
  }

  /// Create updated patient model from controllers
  PatientModel createUpdatedPatient(PatientModel originalPatient) {
    return originalPatient.copyWith(
      username: username.text,
      name: fullNameController.text,
      email: emailController.text,
      bloodType: bloodTypeController.text,
      bmi: double.tryParse(bmiController.text) ?? 0.0,
      dateOfBirth: dobController.text,
      gender: genderController.text,
      physicalHealth: int.tryParse(physicalHealthController.text) ?? 0,
      mentalHealth: int.tryParse(mentalHealthController.text) ?? 0,
      ageCategory: ageCategoryController.text,
      race: raceController.text,
      diabetic: diabeticController.text,
      genHealth: genHealthController.text,
      sleepTime: int.tryParse(sleepTimeController.text) ?? 0,
      physicalActivity: physicalActivityController.text == 'Yes',
      diffWalking: diffWalkingController.text == 'Yes',
      asthma: asthmaController.text == 'Yes',
      kidneyDisease: kidneyDiseaseController.text == 'Yes',
      skinCancer: skinCancerController.text == 'Yes',
      // Old fields
      height: int.tryParse(heightController.text) ?? 0,
      weight: int.tryParse(weightController.text) ?? 0,
      chronicCondition: chronicController.text,
      diabetes: diabetesController.text == 'Yes',
      heartRate: int.tryParse(heartRateController.text) ?? 0,
      smoking: smokingController.text == 'Yes',
      alcoholDrinking: alcoholDrinkingController.text == 'Yes',
      stroke: strokeController.text == 'Yes',
    );
  }

  /// Create updated doctor model from controllers
  DoctorModel createUpdatedDoctor(DoctorModel originalDoctor) {
    return originalDoctor.copyWith(
      username: username.text,
      name: fullNameController.text,
      email: emailController.text,
      phone: phoneController.text,
      clinicAddress: clinicAddressController.text,
      clinicName: clinicNameController.text,
      experienceYears: int.tryParse(experienceYearsController.text) ?? 0,
      gender: genderController.text,
    );
  }

  /// Dispose all controllers
  void disposeControllers() {
    username.dispose();
    fullNameController.dispose();
    emailController.dispose();
    genderController.dispose();
    bloodTypeController.dispose();
    bmiController.dispose();
    dobController.dispose();
    physicalHealthController.dispose();
    mentalHealthController.dispose();
    ageCategoryController.dispose();
    raceController.dispose();
    diabeticController.dispose();
    genHealthController.dispose();
    sleepTimeController.dispose();
    physicalActivityController.dispose();
    diffWalkingController.dispose();
    asthmaController.dispose();
    kidneyDiseaseController.dispose();
    skinCancerController.dispose();
    heightController.dispose();
    weightController.dispose();
    chronicController.dispose();
    diabetesController.dispose();
    heartRateController.dispose();
    smokingController.dispose();
    alcoholDrinkingController.dispose();
    strokeController.dispose();
    phoneController.dispose();
    nationalityController.dispose();
    clinicNameController.dispose();
    clinicAddressController.dispose();
    specializationController.dispose();
    experienceYearsController.dispose();
    ratingController.dispose();
  }
}
