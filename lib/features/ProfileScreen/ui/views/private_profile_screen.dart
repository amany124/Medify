import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

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
  bool isEditing = false;

  // Common controllers
  final TextEditingController username = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  // Patient-specific controllers
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController chronicController = TextEditingController();
  final TextEditingController diabetesController = TextEditingController();
  final TextEditingController heartRateController = TextEditingController();

  // Doctor-specific controllers
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
    heightController.text = patient.height.toString();
    weightController.text = patient.weight.toString();
    chronicController.text = patient.chronicCondition ?? '';
    diabetesController.text = patient.diabetes ? 'Yes' : 'No';
    heartRateController.text = patient.heartRate.toString();
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
          label: "Height",
          controller: heightController,
          icon: Icons.height,
          enabled: isEditing),
      ProfileTextField(
          label: "Weight",
          controller: weightController,
          icon: Icons.monitor_weight,
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
          enabled: isEditing),
      ProfileTextField(
          label: "Heart Rate",
          controller: heartRateController,
          icon: Icons.favorite,
          enabled: isEditing),
    ];
  }

  // 🔹 Build Doctor Profile
  Widget _buildDoctorProfileScreen(DoctorModel doctor) {
    // Fill controllers with data
    username.text = doctor.username;
    fullNameController.text = doctor.name;
    emailController.text = doctor.email;
    genderController.text = doctor.gender;
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
    ];
  }

// 🔹 تعديل في _buildProfileScreen لإضافة زر الحفظ
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
            if (isEditing) // 🔹 إظهار الزر فقط عند التعديل
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
                        height: int.tryParse(heightController.text) ?? 0,
                        weight: int.tryParse(weightController.text) ?? 0,
                        dateOfBirth: dobController.text,
                        gender: genderController.text,
                        chronicCondition: chronicController.text,
                        diabetes: diabetesController.text == 'Yes',
                        heartRate: int.tryParse(heartRateController.text) ?? 0,
                      );
                      context.read<GetProfileCubit>().updatePatientProfile(
                            patientModel: updatedPatient,
                          );
                    } else if (doctor != null) {
                      final updatedDoctor = doctor!.copyWith(
                        username: username.text,
                        name: fullNameController.text,
                        email: emailController.text,
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
}
