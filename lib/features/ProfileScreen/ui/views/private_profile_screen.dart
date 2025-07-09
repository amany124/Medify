import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_cubit.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_state.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_cubit.dart';
import 'package:medify/features/medical_records/presentation/cubit/medical_records_state.dart';

import '../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubit/get_profile_cubit.dart';
import '../widgets/ProfileAppbarContent.dart';
import '../widgets/ProfileTextField.dart';

class PrivateProfileScreen extends StatefulWidget {
  const PrivateProfileScreen({super.key});

  @override
  PrivateProfileScreenState createState() => PrivateProfileScreenState();
}

class PrivateProfileScreenState extends State<PrivateProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final role = CacheManager.getData(key: 'role');
      print('role is $role');
      if (role == 'Doctor') {
        context.read<GetProfileCubit>().getDoctorProfile();
      } else {
        context.read<GetProfileCubit>().getPatientProfile();
      }
    });
  }

  bool isEditing = false;

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

  final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');
  PatientModel? patient;
  DoctorModel? doctor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<GetProfileCubit, GetProfileState>(
        builder: (context, state) {
          if (state is GetProfileLoading) {
            return _buildLoading();
          } else if (state is GetDoctorProfileSuccess) {
            doctor = state.doctorModel!;
            return _buildDoctorProfileScreen(state.doctorModel!);
          } else if (state is GetPatientProfileSuccess) {
            patient = state.patientModel!;

            return _buildPatientProfileScreen(state.patientModel!);
          } else if (state is GetProfileFailure) {
            return _buildError(state.failure.message);
          } else if (state is GetProfileInitial) {
            return const Center(child: Text('No data available'));
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  // 🔹 Loading Widget
  Widget _buildLoading() {
    return Center(
      child: LoadingAnimationWidget.hexagonDots(
        color: AppColors.secondaryColor,
        size: 50,
      ),
    );
  }

  // 🔹 Error Widget
  Widget _buildError(String message) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Error: $message',
          style: AppStyles.semiBold14.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // 🔹 Build Patient Profile
  Widget _buildPatientProfileScreen(PatientModel patient) {
    // Fill controllers with data
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

    return _buildProfileScreen(
      name: patient.name,
      fields: _buildPatientFields(),
    );
  }

  List<Widget> _buildPatientFields() {
    return [
      ProfileTextField(
          label: "Blood Type",
          controller: bloodTypeController,
          icon: Icons.bloodtype,
          enabled: isEditing),
      ProfileTextField(
          label: "Height (cm)",
          controller: heightController,
          icon: Icons.height,
          enabled: isEditing),
      ProfileTextField(
          label: "Weight (kg)",
          controller: weightController,
          icon: Icons.monitor_weight,
          enabled: isEditing),
      ProfileTextField(
          label: "BMI",
          controller: bmiController,
          icon: Icons.monitor_weight,
          enabled: isEditing),
      ProfileTextField(
          label: "Heart Rate (bpm)",
          controller: heartRateController,
          icon: Icons.favorite,
          enabled: isEditing),
      ProfileTextField(
          label: "Date of Birth",
          controller: dobController,
          icon: Icons.cake,
          enabled: isEditing),
      ProfileTextField(
          label: "Chronic Conditions",
          controller: chronicController,
          icon: Icons.medical_services,
          enabled: isEditing),
      ProfileTextField(
          label: "Diabetes",
          controller: diabetesController,
          icon: Icons.medical_information,
          enabled: false),
      ProfileTextField(
          label: "Physical Health (1-30)",
          controller: physicalHealthController,
          icon: Icons.fitness_center,
          enabled: isEditing),
      ProfileTextField(
          label: "Mental Health (1-30)",
          controller: mentalHealthController,
          icon: Icons.psychology,
          enabled: isEditing),
      ProfileTextField(
          label: "Age Category",
          controller: ageCategoryController,
          icon: Icons.cake,
          enabled: isEditing),
      ProfileTextField(
          label: "Race",
          controller: raceController,
          icon: Icons.people,
          enabled: isEditing),
      ProfileTextField(
          label: "Diabetic Status",
          controller: diabeticController,
          icon: Icons.medical_information,
          enabled: isEditing),
      ProfileTextField(
          label: "General Health",
          controller: genHealthController,
          icon: Icons.health_and_safety,
          enabled: isEditing),
      ProfileTextField(
          label: "Sleep Time (hours)",
          controller: sleepTimeController,
          icon: Icons.bedtime,
          enabled: isEditing),
      ProfileTextField(
          label: "Physical Activity",
          controller: physicalActivityController,
          icon: Icons.directions_run,
          enabled: false),
      ProfileTextField(
          label: "Difficulty Walking",
          controller: diffWalkingController,
          icon: Icons.accessible,
          enabled: false),
      ProfileTextField(
          label: "Smoking",
          controller: smokingController,
          icon: Icons.smoking_rooms,
          enabled: false),
      ProfileTextField(
          label: "Alcohol Drinking",
          controller: alcoholDrinkingController,
          icon: Icons.local_bar,
          enabled: false),
      ProfileTextField(
          label: "Stroke History",
          controller: strokeController,
          icon: Icons.emergency,
          enabled: false),
      ProfileTextField(
          label: "Asthma",
          controller: asthmaController,
          icon: Icons.air,
          enabled: false),
      ProfileTextField(
          label: "Kidney Disease",
          controller: kidneyDiseaseController,
          icon: Icons.medical_services,
          enabled: false),
      ProfileTextField(
          label: "Skin Cancer",
          controller: skinCancerController,
          icon: Icons.health_and_safety,
          enabled: false),

      // Diagnosis Data Section
      _buildDiagnosisDataSection(),
    ];
  }

  // 🔹 Build Doctor Profile
  Widget _buildDoctorProfileScreen(DoctorModel doctor) {
    // Fill controllers with data
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

    return _buildProfileScreen(
      name: doctor.name,
      fields: _buildDoctorFields(),
    );
  }

  List<Widget> _buildDoctorFields() {
    return [
      ProfileTextField(
          label: "Phone",
          controller: phoneController,
          icon: Icons.phone,
          enabled: isEditing),
      ProfileTextField(
          label: "Nationality",
          controller: nationalityController,
          icon: Icons.flag,
          enabled: isEditing),
      ProfileTextField(
          label: "Clinic Name",
          controller: clinicNameController,
          icon: Icons.local_hospital,
          enabled: isEditing),
      ProfileTextField(
          label: "Clinic Address",
          controller: clinicAddressController,
          icon: Icons.location_on,
          enabled: isEditing),
      ProfileTextField(
          label: "Specialization",
          controller: specializationController,
          icon: Icons.work,
          enabled: isEditing),
      ProfileTextField(
          label: "Experience Years",
          controller: experienceYearsController,
          icon: Icons.history,
          enabled: isEditing),
      ProfileTextField(
          label: "Rating",
          controller: ratingController,
          icon: Icons.star,
          enabled: false),

      // Doctor Verification Section
      _buildDoctorVerificationSection(),

      // Medical Records Section
      _buildMedicalRecordsSection(),
    ];
  }

  Widget _buildProfileScreen(
      {required String name, required List<Widget> fields}) {
    return NestedScrollView(
      physics: const BouncingScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            floating: false,
            elevation: 0,
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/profilebackground2png.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ProfileAppbarContent(name: name),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(isEditing ? Icons.check : Icons.edit,
                    color: Colors.white),
                onPressed: () => setState(() => isEditing = !isEditing),
              ),
            ],
          ),
        ];
      },
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...fields,
            if (isEditing)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CustomButton(
                  text: 'Save',
                  backgroundColor: AppColors.secondaryColor,
                  textColor: Colors.white,
                  buttonWidth: 200,
                  onPressed: () {
                    if (patient != null) {
                      final updatedPatient = patient!.copyWith(
                        username: username.text,
                        name: fullNameController.text,
                        email: emailController.text,
                        bloodType: bloodTypeController.text,
                        bmi: double.tryParse(bmiController.text) ?? 0.0,
                        dateOfBirth: dobController.text,
                        gender: genderController.text,
                        physicalHealth:
                            int.tryParse(physicalHealthController.text) ?? 0,
                        mentalHealth:
                            int.tryParse(mentalHealthController.text) ?? 0,
                        ageCategory: ageCategoryController.text,
                        race: raceController.text,
                        diabetic: diabeticController.text,
                        genHealth: genHealthController.text,
                        sleepTime: int.tryParse(sleepTimeController.text) ?? 0,
                        physicalActivity:
                            physicalActivityController.text == 'Yes',
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
                        alcoholDrinking:
                            alcoholDrinkingController.text == 'Yes',
                        stroke: strokeController.text == 'Yes',
                      );
                      context.read<GetProfileCubit>().updatePatientProfile(
                            patientModel: updatedPatient,
                          );
                    } else if (doctor != null) {
                      final updatedDoctor = doctor!.copyWith(
                        username: username.text,
                        name: fullNameController.text,
                        email: emailController.text,
                        phone: phoneController.text,
                        clinicAddress: clinicAddressController.text,
                        clinicName: clinicNameController.text,
                        experienceYears:
                            int.tryParse(experienceYearsController.text) ?? 0,
                        gender: genderController.text,
                      );
                      context.read<GetProfileCubit>().updateDoctorProfile(
                            doctorModel: updatedDoctor,
                          );
                    }
                    showCustomSnackBar('Profile Updated successfully', context);

                    setState(() {
                      isEditing = false;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  // 🔹 Build Diagnosis Data Section for Patients
  Widget _buildDiagnosisDataSection() {
    if (patient == null) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade50.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.blue.shade600,
                  Colors.blue.shade500,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.analytics,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diagnosis Data',
                        style: AppStyles.semiBold18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Health metrics and risk factors',
                        style: AppStyles.regular12.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Data Grid
          _buildDiagnosisDataGrid(),
        ],
      ),
    );
  }

  // 🔹 Build Diagnosis Data Grid
  Widget _buildDiagnosisDataGrid() {
    final diagnosisData = [
      {
        'label': 'BMI',
        'value': patient!.bmi.toString(),
        'icon': Icons.monitor_weight,
        'color': Colors.cyan
      },
      {
        'label': 'Smoking',
        'value': patient!.smoking ? 'Yes' : 'No',
        'icon': Icons.smoking_rooms,
        'color': Colors.red
      },
      {
        'label': 'Alcohol Drinking',
        'value': patient!.alcoholDrinking ? 'Yes' : 'No',
        'icon': Icons.local_bar,
        'color': Colors.red
      },
      {
        'label': 'Stroke',
        'value': patient!.stroke ? 'Yes' : 'No',
        'icon': Icons.emergency,
        'color': Colors.red
      },
      {
        'label': 'Physical Health',
        'value': '${patient!.physicalHealth}/30',
        'icon': Icons.fitness_center,
        'color': Colors.blue
      },
      {
        'label': 'Mental Health',
        'value': '${patient!.mentalHealth}/30',
        'icon': Icons.psychology,
        'color': Colors.blue
      },
      {
        'label': 'Difficulty Walking',
        'value': patient!.diffWalking ? 'Yes' : 'No',
        'icon': Icons.accessible,
        'color': Colors.red
      },
      {
        'label': 'Sex',
        'value': patient!.gender,
        'icon': Icons.person,
        'color': Colors.cyan
      },
      {
        'label': 'Age Category',
        'value': patient!.ageCategory,
        'icon': Icons.cake,
        'color': Colors.blue
      },
      {
        'label': 'Race',
        'value': patient!.race,
        'icon': Icons.people,
        'color': Colors.blue
      },
      {
        'label': 'Diabetic',
        'value': patient!.diabetic,
        'icon': Icons.medical_information,
        'color': Colors.red
      },
      {
        'label': 'Physical Activity',
        'value': patient!.physicalActivity ? 'Yes' : 'No',
        'icon': Icons.directions_run,
        'color': Colors.cyan
      },
      {
        'label': 'General Health',
        'value': patient!.genHealth,
        'icon': Icons.health_and_safety,
        'color': Colors.blue
      },
      {
        'label': 'Sleep Time',
        'value': '${patient!.sleepTime} hours',
        'icon': Icons.bedtime,
        'color': Colors.cyan
      },
      {
        'label': 'Asthma',
        'value': patient!.asthma ? 'Yes' : 'No',
        'icon': Icons.air,
        'color': Colors.cyan
      },
      {
        'label': 'Kidney Disease',
        'value': patient!.kidneyDisease ? 'Yes' : 'No',
        'icon': Icons.medical_services,
        'color': Colors.red
      },
      {
        'label': 'Skin Cancer',
        'value': patient!.skinCancer ? 'Yes' : 'No',
        'icon': Icons.health_and_safety,
        'color': Colors.cyan
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5, //w:h
      ),
      itemCount: diagnosisData.length,
      itemBuilder: (context, index) {
        final data = diagnosisData[index];
        return _buildDiagnosisDataCard(
          label: data['label'] as String,
          value: data['value'] as String,
          icon: data['icon'] as IconData,
          color: data['color'] as Color,
        );
      },
    );
  }

  // 🔹 Build Individual Diagnosis Data Card
  Widget _buildDiagnosisDataCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: color,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: AppStyles.regular10.copyWith(
                    color: Colors.grey.shade600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: AppStyles.semiBold12.copyWith(
                    color: color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalRecordsSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            AppColors.secondaryColor.withValues(alpha: 0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.secondaryColor.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryColor.withValues(alpha: 0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.secondaryColor,
                  AppColors.secondaryColor.withValues(alpha: 0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.medical_services,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Records',
                        style: AppStyles.semiBold18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Patient treatment history',
                        style: AppStyles.regular12.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: BlocProvider(
                    create: (context) =>
                        getIt<MedicalRecordsCubit>()..getMedicalRecords(),
                    child:
                        BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
                      builder: (context, state) {
                        if (state is MedicalRecordsLoaded) {
                          return Text(
                            '${state.records.data.length} Records',
                            style: AppStyles.semiBold12.copyWith(
                              color: Colors.white,
                            ),
                          );
                        }
                        return Text(
                          '0 Records',
                          style: AppStyles.semiBold12.copyWith(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Records List
          BlocProvider(
            create: (context) =>
                getIt<MedicalRecordsCubit>()..getMedicalRecords(),
            child: BlocBuilder<MedicalRecordsCubit, MedicalRecordsState>(
              builder: (context, state) {
                if (state is MedicalRecordsLoading) {
                  return Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 12),
                          Text(
                            'Loading medical records...',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (state is MedicalRecordsLoaded) {
                  final records = state.records.data;
                  if (records.isEmpty) {
                    return Container(
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.folder_open,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No medical records found',
                              style: AppStyles.semiBold14.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              'Create your first medical record',
                              style: AppStyles.regular12.copyWith(
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: records
                        .map((record) => _buildMedicalRecordCard(record))
                        .toList(),
                  );
                } else if (state is MedicalRecordsError) {
                  return Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Error loading records',
                            style: AppStyles.semiBold14.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                          Text(
                            state.message,
                            style: AppStyles.regular12.copyWith(
                              color: Colors.red.shade600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Build Doctor Verification Section
  Widget _buildDoctorVerificationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.teal.shade50.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.teal.shade600,
                  Colors.teal.shade500,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.verified_user,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Doctor Verification',
                        style: AppStyles.semiBold18.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Upload credentials for verification',
                        style: AppStyles.regular12.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange, width: 1.5),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.pending, size: 16, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        'Pending',
                        style:
                            AppStyles.semiBold10.copyWith(color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Upload Instructions
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.teal.shade600, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Verification Requirements',
                        style: AppStyles.semiBold14
                            .copyWith(color: Colors.teal.shade700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Upload a clear image of your medical license or certification',
                        style: AppStyles.regular12
                            .copyWith(color: Colors.teal.shade600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Upload Button or Image Preview
          BlocProvider(
            create: (context) => getIt<VerifyDoctorCubit>(),
            child: BlocConsumer<VerifyDoctorCubit, VerifyDoctorState>(
              listener: (context, state) {
                if (state is VerifyDoctorSuccess) {
                  showCustomSnackBar(
                    'Verification document uploaded successfully!',
                    context,
                  );
                  // Refresh the doctor profile to show updated verification image
                  context.read<GetProfileCubit>().getDoctorProfile();
                } else if (state is VerifyDoctorError) {
                  showCustomSnackBar(
                    'Upload failed: ${state.message}',
                    context,
                  );
                }
              },
              builder: (context, state) {
                // Check if doctor has verification image
                if (doctor?.verificationImage != null &&
                    doctor!.verificationImage!.isNotEmpty) {
                  // Show image preview
                  return _buildVerificationImagePreview(
                      context, doctor!.verificationImage!);
                } else {
                  // Show upload button
                  return _buildUploadButton(context, state);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Build Upload Button
  Widget _buildUploadButton(BuildContext context, VerifyDoctorState state) {
    return CustomButton(
      text: state is VerifyDoctorLoading
          ? 'Uploading...'
          : 'Upload Verification Document',
      backgroundColor: state is VerifyDoctorLoading
          ? Colors.grey.shade400
          : Colors.teal.shade600,
      textColor: Colors.white,
      buttonWidth: double.infinity,
      onPressed: state is VerifyDoctorLoading
          ? () {} // Disabled when loading
          : () => _showImagePicker(context),
    );
  }

  // 🔹 Build Verification Image Preview
  Widget _buildVerificationImagePreview(BuildContext context, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview Label
        Row(
          children: [
            Icon(Icons.verified, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            Text(
              'Verification Document',
              style: AppStyles.semiBold14.copyWith(
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Image Preview Container
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imageUrl.startsWith('http')
                ? Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 48, color: Colors.grey.shade400),
                            const SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: AppStyles.regular12.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image,
                            size: 48, color: Colors.grey.shade400),
                        const SizedBox(height: 8),
                        Text(
                          'Invalid image URL',
                          style: AppStyles.regular12.copyWith(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 12),

        // Action Buttons
        Row(
          children: [
            Expanded(
              child: CustomButton(
                text: 'View Full Size',
                backgroundColor: Colors.green.shade50,
                textColor: Colors.green.shade700,
                buttonWidth: double.infinity,
                buttonHeight: 40,
                onPressed: () => _showFullSizeImage(context, imageUrl),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: CustomButton(
                text: 'Replace Image',
                backgroundColor: Colors.orange.shade50,
                textColor: Colors.orange.shade700,
                buttonWidth: double.infinity,
                buttonHeight: 40,
                onPressed: () => _showImagePicker(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 🔹 Show Image Picker for Verification
  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Select Verification Document',
                style: AppStyles.semiBold18.copyWith(
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    onTap: () => _pickImageFromCamera(context),
                  ),
                  _buildImagePickerOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () => _pickImageFromGallery(context),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Build Image Picker Option
  Widget _buildImagePickerOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.teal.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.teal.shade200),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.teal.shade600,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppStyles.semiBold14.copyWith(
                color: Colors.teal.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Show Full Size Image
  void _showFullSizeImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: InteractiveViewer(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline,
                                size: 64, color: Colors.white),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load image',
                              style: AppStyles.regular16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Pick Image from Camera (Placeholder for now)
  void _pickImageFromCamera(BuildContext context) async {
    Navigator.pop(context);
    // You'll need to add image_picker package
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _submitVerification(context, File(image.path));
    }

    showCustomSnackBar(
        'Camera functionality will be implemented with image_picker package',
        context);
  }

  // 🔹 Pick Image from Gallery (Placeholder for now)
  void _pickImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    // You'll need to add image_picker package
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _submitVerification(context, File(image.path));
    }

    showCustomSnackBar(
        'Gallery functionality will be implemented with image_picker package',
        context);
  }

  // 🔹 Submit Verification (for when image picker is implemented)
  void _submitVerification(BuildContext context, File imageFile) {
    context.read<VerifyDoctorCubit>().verifyDoctorProfile(imageFile: imageFile);
  }

  Widget _buildMedicalRecordCard(dynamic record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border:
            Border.all(color: AppColors.secondaryColor.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Card Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.person,
                    color: AppColors.secondaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.patient?.name ?? 'Unknown Patient',
                        style: AppStyles.semiBold14.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      Text(
                        'ID: ${record.patientId}',
                        style: AppStyles.regular10.copyWith(
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Created: ${_formatMedicalRecordDate(record.date)}',
                        style: AppStyles.regular12.copyWith(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getTypeColor(record.type),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    record.type.toUpperCase(),
                    style: AppStyles.semiBold10.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Diagnosis Section
                _buildDataRow(
                  icon: Icons.medical_information,
                  label: 'Diagnosis',
                  value: record.diagnosis,
                  color: Colors.red.shade600,
                ),

                const SizedBox(height: 12),

                // Treatment Section
                _buildDataRow(
                  icon: Icons.healing,
                  label: 'Treatment',
                  value: record.treatment,
                  color: Colors.green.shade600,
                ),

                // Symptoms Section
                if (record.symptoms.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.sick,
                          size: 16,
                          color: Colors.orange.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Symptoms',
                              style: AppStyles.semiBold12.copyWith(
                                color: Colors.orange.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Wrap(
                              spacing: 6,
                              runSpacing: 4,
                              children: record.symptoms.map<Widget>((symptom) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.orange.shade200,
                                    ),
                                  ),
                                  child: Text(
                                    symptom,
                                    style: AppStyles.regular10.copyWith(
                                      color: Colors.orange.shade700,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                // Notes Section
                if (record.notes != null &&
                    record.notes.isNotEmpty &&
                    record.notes != 'No Notes !') ...[
                  const SizedBox(height: 12),
                  _buildDataRow(
                    icon: Icons.note_alt,
                    label: 'Notes',
                    value: record.notes,
                    color: Colors.blue.shade600,
                  ),
                ],

                // Attachments Section
                if (record.attachments != null &&
                    record.attachments.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Icon(
                          Icons.attach_file,
                          size: 16,
                          color: Colors.purple.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Attachments (${record.attachments.length})',
                        style: AppStyles.semiBold12.copyWith(
                          color: Colors.purple.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 16,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.semiBold12.copyWith(
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppStyles.regular12.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'emergency':
        return Colors.red.shade600;
      case 'consultation':
        return Colors.blue.shade600;
      case 'checkup':
        return Colors.green.shade600;
      default:
        return AppColors.secondaryColor;
    }
  }

  // 🔹 Helper method to format medical record date
  String _formatMedicalRecordDate(DateTime? date) {
    if (date == null) return 'Unknown date';

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday ${DateFormat('HH:mm').format(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date);
    }
  }
}
