import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/core/widgets/custom_button.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

import '../cubit/get_profile_cubit.dart';
import '../mixins/profile_controllers_mixin.dart';
import '../widgets/ProfileAppbarContent.dart';
import '../widgets/doctor_profile_fields.dart';
import '../widgets/doctor_verification_section.dart';
import '../widgets/medical_records_section.dart';
import '../widgets/patient_profile_fields.dart';

class PrivateProfileScreen extends StatefulWidget {
  const PrivateProfileScreen({super.key});

  @override
  PrivateProfileScreenState createState() => PrivateProfileScreenState();
}

class PrivateProfileScreenState extends State<PrivateProfileScreen>
    with ProfileControllersMixin {
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

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  bool isEditing = false;
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
    // Fill controllers with data using the mixin method
    populatePatientControllers(patient);

    return _buildProfileScreen(
      name: patient.name,
      fields: [
        PatientProfileFields(
          patient: patient,
          isEditing: isEditing,
          controllers: _getControllersMap(),
        ),
      ],
    );
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
      'phone': phoneController,
      'nationality': nationalityController,
      'clinicName': clinicNameController,
      'clinicAddress': clinicAddressController,
      'specialization': specializationController,
      'experienceYears': experienceYearsController,
      'rating': ratingController,
    };
  }

  // 🔹 Build Doctor Profile
  Widget _buildDoctorProfileScreen(DoctorModel doctor) {
    // Fill controllers with data using the mixin method
    populateDoctorControllers(doctor);

    return _buildProfileScreen(
      name: doctor.name,
      fields: [
        DoctorProfileFields(
          doctor: doctor,
          isEditing: isEditing,
          controllers: _getControllersMap(),
        ),

        // Doctor Verification Section
        DoctorVerificationSection(
          doctor: doctor,
        ),

        // Medical Records Section
        const MedicalRecordsSection(),
      ],
    );
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
                      final updatedPatient = createUpdatedPatient(patient!);
                      context.read<GetProfileCubit>().updatePatientProfile(
                            patientModel: updatedPatient,
                          );
                    } else if (doctor != null) {
                      final updatedDoctor = createUpdatedDoctor(doctor!);
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
}
