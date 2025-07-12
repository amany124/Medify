import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/core/widgets/custom_button.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_request_model.dart';
import 'package:medify/features/heart%20diseases/presentation/cubit/predict_disease_cubit.dart';

import '../mixins/profile_controllers_mixin.dart';
import '../widgets/patient_profile_fields.dart';

class PatientEditScreen extends StatefulWidget {
  final PatientModel patient;
  final bool navigateToPrediction;

  const PatientEditScreen({
    super.key,
    required this.patient,
    this.navigateToPrediction = false,
  });

  @override
  PatientEditScreenState createState() => PatientEditScreenState();
}

class PatientEditScreenState extends State<PatientEditScreen>
    with ProfileControllersMixin {
  @override
  void initState() {
    super.initState();
    // Pre-fill the form with the patient's original data
    populatePatientControllers(widget.patient);
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Patient Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Update Your Information',
                    style: AppStyles.semiBold16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Edit your profile information below. The updated data will be used for health analysis.',
                    style: AppStyles.regular14.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Patient Profile Fields
            PatientProfileFields(
              patient: widget.patient,
              isEditing: true,
              controllers: _getControllersMap(),
            ),

            const SizedBox(height: 30),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Cancel',
                    backgroundColor: Colors.grey[300]!,
                    textColor: Colors.black,
                    buttonWidth: double.infinity,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomButton(
                    text: widget.navigateToPrediction
                        ? 'Update & Predict'
                        : 'Save Changes',
                    backgroundColor: AppColors.primaryColor,
                    textColor: Colors.white,
                    buttonWidth: double.infinity,
                    onPressed: () {
                      _saveAndNavigate();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _saveAndNavigate() {
    // Create updated patient model with new data
    final updatedPatient = createUpdatedPatient(widget.patient);

    if (widget.navigateToPrediction) {
      // Navigate to heart disease prediction with updated data
      final heartDiseaseRequest = _createHeartDiseaseRequest(updatedPatient);

      // Set the request in the cubit
      context.read<PredictDiseaseCubit>().setRequest(heartDiseaseRequest);

      // Navigate back and trigger prediction
      Navigator.pop(context, updatedPatient);

      // Show success message
      showCustomSnackBar(
        'Profile updated! Starting health analysis...',
        context,
      );
    } else {
      // Just save the changes and go back
      Navigator.pop(context, updatedPatient);
      showCustomSnackBar('Profile updated successfully', context);
    }
  }

  /// Get controllers map for the widgets
  Map<String, TextEditingController> _getControllersMap() {
    return {
      'username': username,
      'fullName': fullNameController,
      'email': emailController,
      'gender': genderController,
      'bloodType': bloodTypeController,
      'bmi': bmiController,
      'dob': dobController,
      'physicalHealth': physicalHealthController,
      'mentalHealth': mentalHealthController,
      'ageCategory': ageCategoryController,
      'race': raceController,
      'diabetic': diabeticController,
      'genHealth': genHealthController,
      'sleepTime': sleepTimeController,
      'physicalActivity': physicalActivityController,
      'diffWalking': diffWalkingController,
      'asthma': asthmaController,
      'kidneyDisease': kidneyDiseaseController,
      'skinCancer': skinCancerController,
      'height': heightController,
      'weight': weightController,
      'chronic': chronicController,
      'diabetes': diabetesController,
      'heartRate': heartRateController,
      'smoking': smokingController,
      'alcoholDrinking': alcoholDrinkingController,
      'stroke': strokeController,
    };
  }

  /// Create HeartDiseasesRequest from updated patient data
  HeartDiseasesRequest _createHeartDiseaseRequest(PatientModel patient) {
    return HeartDiseasesRequest(
      bmi: patient.bmi,
      smoking: patient.smoking ? 'Yes' : 'No',
      alcoholDrinking: patient.alcoholDrinking ? 'Yes' : 'No',
      stroke: patient.stroke ? 'Yes' : 'No',
      physicalHealth: patient.physicalHealth,
      mentalHealth: patient.mentalHealth,
      diffWalking: patient.diffWalking ? 'Yes' : 'No',
      sex: patient.gender.toLowerCase() == 'male' ? 'Male' : 'Female',
      ageCategory: patient.ageCategory,
      race: patient.race,
      diabetic: patient.diabetic,
      physicalActivity: patient.physicalActivity ? 'Yes' : 'No',
      genHealth: patient.genHealth,
      sleepTime: patient.sleepTime,
      asthma: patient.asthma ? 'Yes' : 'No',
      kidneyDisease: patient.kidneyDisease ? 'Yes' : 'No',
      skinCancer: patient.skinCancer ? 'Yes' : 'No',
    );
  }
}
