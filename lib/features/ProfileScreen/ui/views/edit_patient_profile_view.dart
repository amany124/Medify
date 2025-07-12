import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/core/widgets/custom_button.dart';
import 'package:medify/features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';
import 'package:medify/features/authentication/register/ui/widgets/section_components.dart';
import 'package:medify/features/heart%20diseases/data/models/heart_diseases_request_model.dart';
import 'package:medify/features/heart%20diseases/presentation/cubit/predict_disease_cubit.dart';
import 'package:medify/features/heart%20diseases/presentation/cubit/predict_disease_state.dart';

import '../../../heart diseases/ui/views/bad_result.dart';
import '../../../heart diseases/ui/views/good_result.dart';

class EditPatientProfileView extends StatefulWidget {
  final PatientModel patient;

  const EditPatientProfileView({
    super.key,
    required this.patient,
  });

  @override
  State<EditPatientProfileView> createState() => _EditPatientProfileViewState();
}

class _EditPatientProfileViewState extends State<EditPatientProfileView> {
  // Initialize PatientModel with original data
  late PatientModel patientModel;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _chronicConditionController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _physicalHealthController =
      TextEditingController();
  final TextEditingController _mentalHealthController = TextEditingController();
  final TextEditingController _sleepTimeController = TextEditingController();

  // Dropdown values
  String? _bloodType;
  String? _diabetesStatus;
  String? _gender;
  String? _ageCategory;
  String? _race;
  String? _genHealth;

  // Boolean values
  bool _physicalActivity = false;
  bool _diffWalking = false;
  bool _asthma = false;
  bool _kidneyDisease = false;
  bool _skinCancer = false;
  bool _smoking = false;
  bool _alcoholDrinking = false;
  bool _stroke = false;
  bool _diabetes = false;

  // Lists for dropdown options
  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  final List<String> diabetesOptions = ['No', 'Yes', 'Borderline diabetes'];
  final List<String> genderOptions = ['male', 'female'];
  final List<String> ageCategoryOptions = [
    '18-24',
    '25-29',
    '30-34',
    '35-39',
    '40-44',
    '45-49',
    '50-54',
    '55-59',
    '60-64',
    '65-69',
    '70-74',
    '75-79',
    '80+'
  ];
  final List<String> raceOptions = [
    'White',
    'Black',
    'Asian',
    'Hispanic',
    'American Indian/Alaskan Native',
    'Other'
  ];
  final List<String> genHealthOptions = [
    'Excellent',
    'Very good',
    'Good',
    'Fair',
    'Poor'
  ];

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize patient model with original data
    patientModel = PatientModel(
      name: widget.patient.name,
      email: widget.patient.email,
      username: widget.patient.username,
      password: widget.patient.password,
      role: widget.patient.role,
      gender: widget.patient.gender,
      dateOfBirth: widget.patient.dateOfBirth,
      bloodType: widget.patient.bloodType,
      height: widget.patient.height,
      weight: widget.patient.weight,
      chronicCondition: widget.patient.chronicCondition,
      heartRate: widget.patient.heartRate,
      bmi: widget.patient.bmi,
      smoking: widget.patient.smoking,
      alcoholDrinking: widget.patient.alcoholDrinking,
      stroke: widget.patient.stroke,
      physicalHealth: widget.patient.physicalHealth,
      mentalHealth: widget.patient.mentalHealth,
      diffWalking: widget.patient.diffWalking,
      ageCategory: widget.patient.ageCategory,
      race: widget.patient.race,
      diabetic: widget.patient.diabetic,
      physicalActivity: widget.patient.physicalActivity,
      genHealth: widget.patient.genHealth,
      sleepTime: widget.patient.sleepTime,
      asthma: widget.patient.asthma,
      kidneyDisease: widget.patient.kidneyDisease,
      skinCancer: widget.patient.skinCancer,
    );

    // Populate controllers with original data
    _populateControllers();

    // Add listeners for BMI calculation
    _heightController.addListener(_calculateBMI);
    _weightController.addListener(_calculateBMI);
  }

  void _populateControllers() {
    _nameController.text = patientModel.name;
    _emailController.text = patientModel.email;
    _usernameController.text = patientModel.username;
    _heightController.text = patientModel.height?.toString() ?? '';
    _weightController.text = patientModel.weight?.toString() ?? '';
    _bmiController.text = patientModel.bmi.toString();
    _heartRateController.text = patientModel.heartRate.toString();
    _chronicConditionController.text = patientModel.chronicCondition ?? '';
    _dateOfBirthController.text = patientModel.dateOfBirth;
    _physicalHealthController.text = patientModel.physicalHealth.toString();
    _mentalHealthController.text = patientModel.mentalHealth.toString();
    _sleepTimeController.text = patientModel.sleepTime.toString();

    // Set dropdown values
    _bloodType =
        patientModel.bloodType.isNotEmpty ? patientModel.bloodType : null;
    _diabetesStatus =
        patientModel.diabetic.isNotEmpty ? patientModel.diabetic : null;
    _gender = patientModel.gender.isNotEmpty ? patientModel.gender : null;
    _ageCategory =
        patientModel.ageCategory.isNotEmpty ? patientModel.ageCategory : null;
    _race = patientModel.race.isNotEmpty ? patientModel.race : null;
    _genHealth =
        patientModel.genHealth.isNotEmpty ? patientModel.genHealth : null;

    // Set boolean values
    _physicalActivity = patientModel.physicalActivity;
    _diffWalking = patientModel.diffWalking;
    _asthma = patientModel.asthma;
    _kidneyDisease = patientModel.kidneyDisease;
    _skinCancer = patientModel.skinCancer;
    _smoking = patientModel.smoking;
    _alcoholDrinking = patientModel.alcoholDrinking;
    _stroke = patientModel.stroke;
    _diabetes = patientModel.diabetic == 'Yes';
  }

  @override
  void dispose() {
    // Dispose of all controllers
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _bmiController.dispose();
    _heartRateController.dispose();
    _chronicConditionController.dispose();
    _dateOfBirthController.dispose();
    _physicalHealthController.dispose();
    _mentalHealthController.dispose();
    _sleepTimeController.dispose();
    super.dispose();
  }

  // Calculate BMI and update the BMI controller
  void _calculateBMI() {
    final heightText = _heightController.text.trim();
    final weightText = _weightController.text.trim();

    if (heightText.isNotEmpty && weightText.isNotEmpty) {
      final height = double.tryParse(heightText);
      final weight = double.tryParse(weightText);

      if (height != null && weight != null && height > 0) {
        final heightInMeters = height / 100; // Convert cm to meters
        final bmi = weight / (heightInMeters * heightInMeters);
        _bmiController.text = bmi.toStringAsFixed(1);
        patientModel.bmi = bmi;
        setState(() {}); // Update UI for BMI indicator
      }
    }
  }

  // Function to get BMI category
  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25.0) return 'Normal weight';
    if (bmi < 30.0) return 'Overweight';
    return 'Obese';
  }

  // Function to get BMI color
  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25.0) return Colors.green;
    if (bmi < 30.0) return Colors.orange;
    return Colors.red;
  }

  // Function to get BMI progress value (0.0 to 1.0)
  double _getBMIProgress(double bmi) {
    if (bmi < 18.5) return (bmi / 18.5) * 0.25;
    if (bmi < 25.0) return 0.25 + ((bmi - 18.5) / (25.0 - 18.5)) * 0.25;
    if (bmi < 30.0) return 0.5 + ((bmi - 25.0) / (30.0 - 25.0)) * 0.25;
    return min(0.75 + ((bmi - 30.0) / 10.0) * 0.25, 1.0); // Cap at 1.0
  }

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = "${picked.toLocal()}".split(' ')[0];
        patientModel.dateOfBirth = _dateOfBirthController.text;
      });
    }
  }

  // Build BMI Progress Indicator
  Widget _buildBMIIndicator() {
    final bmi = double.tryParse(_bmiController.text) ?? 0.0;
    if (bmi <= 0) return const SizedBox.shrink();

    return SectionComponents.buildBMIProgressIndicator(
      bmi: bmi,
      category: _getBMICategory(bmi),
      color: _getBMIColor(bmi),
      progress: _getBMIProgress(bmi),
    );
  }

  // Create a heart disease prediction request from patient model
  HeartDiseasesRequest _createHeartDiseaseRequest() {
    return HeartDiseasesRequest(
      bmi: patientModel.bmi,
      smoking: patientModel.smoking ? 'Yes' : 'No',
      alcoholDrinking: patientModel.alcoholDrinking ? 'Yes' : 'No',
      stroke: patientModel.stroke ? 'Yes' : 'No',
      physicalHealth: patientModel.physicalHealth,
      mentalHealth: patientModel.mentalHealth,
      diffWalking: patientModel.diffWalking ? 'Yes' : 'No',
      sex: patientModel.gender,
      ageCategory: patientModel.ageCategory,
      race: patientModel.race,
      diabetic: patientModel.diabetic,
      physicalActivity: patientModel.physicalActivity ? 'Yes' : 'No',
      genHealth: patientModel.genHealth,
      sleepTime: patientModel.sleepTime,
      asthma: patientModel.asthma ? 'Yes' : 'No',
      kidneyDisease: patientModel.kidneyDisease ? 'Yes' : 'No',
      skinCancer: patientModel.skinCancer ? 'Yes' : 'No',
    );
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
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/profilebackground2png.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: BlocListener<PredictDiseaseCubit, PredictDiseaseState>(
        listener: (context, state) {
          if (state is PredictDiseaseSuccess) {
            Future.microtask(() {
              if (!mounted) return;

              if (state.response.diagnosis.contains('⚠️ يوجد خطر للإصابة')) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BadResultPage(
                      heartDiseasesResponse: state.response,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoodResultPage(
                      heartDiseasesResponse: state.response,
                    ),
                  ),
                );
              }
            });
          } else if (state is PredictDiseaseFailure) {
            showCustomSnackBar(
              'Prediction failed: ${state.failure.message}',
              context,
              isError: true,
            );
          }
        },
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions
                Container(
                  margin: const EdgeInsets.all(16),
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

                // Basic Information Section
                _buildBasicInfoSection(),
                const Gap(24),

                // Personal Details Section
                _buildPersonalDetailsSection(),
                const Gap(24),

                // Health Metrics Section
                _buildHealthMetricsSection(),
                const Gap(24),

                // Health Conditions Section
                _buildHealthConditionsSection(),
                const Gap(24),

                // Lifestyle Section
                _buildLifestyleSection(),
                const Gap(24),

                // Action Buttons
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
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
                        child: BlocBuilder<PredictDiseaseCubit,
                            PredictDiseaseState>(
                          builder: (context, state) {
                            final isLoading = state is PredictDiseaseLoading;
                            return CustomButton(
                              text: isLoading
                                  ? 'Analyzing...'
                                  : 'Update & Analyze',
                              backgroundColor: AppColors.primaryColor,
                              textColor: Colors.white,
                              buttonWidth: double.infinity,
                              onPressed: () => _validateAndAnalyze(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Basic Information Section
  Widget _buildBasicInfoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionComponents.buildSectionHeader(
            'Basic Information',
            Icons.person,
            AppColors.primaryColor,
          ),
          const Gap(16),
          SectionComponents.buildSectionCard(
            borderColor: AppColors.primaryColor,
            child: Column(
              children: [
                // Name
                SectionComponents.buildTextField(
                  label: 'Full Name',
                  controller: _nameController,
                  hintText: 'Enter your full name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.name = val ?? '';
                  },
                ),
                const Gap(16),

                // Username
                SectionComponents.buildTextField(
                  label: 'Username',
                  controller: _usernameController,
                  hintText: 'Enter your username',
                  prefixIcon: Icons.account_circle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.username = val ?? '';
                  },
                ),
                const Gap(16),

                // Email
                SectionComponents.buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.email = val ?? '';
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Personal Details Section
  Widget _buildPersonalDetailsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionComponents.buildSectionHeader(
            'Personal Details',
            Icons.assignment_ind,
            Colors.purple,
          ),
          const Gap(16),
          SectionComponents.buildSectionCard(
            borderColor: Colors.purple,
            child: Column(
              children: [
                // Gender Dropdown
                SectionComponents.buildDropdownField<String>(
                  label: 'Gender',
                  value: _gender,
                  items: genderOptions,
                  itemLabel: (item) =>
                      item.substring(0, 1).toUpperCase() + item.substring(1),
                  onChanged: (val) {
                    setState(() {
                      _gender = val;
                      patientModel.gender = val ?? 'male';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your gender';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.gender = val ?? 'male';
                  },
                  hintText: 'Select your gender',
                ),
                const Gap(16),

                // Date of Birth
                SectionComponents.buildTextField(
                  label: 'Date of Birth',
                  controller: _dateOfBirthController,
                  hintText: 'YYYY-MM-DD',
                  prefixIcon: Icons.calendar_today,
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.dateOfBirth = val ?? '';
                  },
                ),
                const Gap(16),

                // Age Category Dropdown
                SectionComponents.buildDropdownField<String>(
                  label: 'Age Category',
                  value: _ageCategory,
                  items: ageCategoryOptions,
                  itemLabel: (item) => item,
                  onChanged: (val) {
                    setState(() {
                      _ageCategory = val;
                      patientModel.ageCategory = val ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your age category';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.ageCategory = val ?? '';
                  },
                  hintText: 'Select your age category',
                ),
                const Gap(16),

                // Race Dropdown
                SectionComponents.buildDropdownField<String>(
                  label: 'Race/Ethnicity',
                  value: _race,
                  items: raceOptions,
                  itemLabel: (item) => item,
                  onChanged: (val) {
                    setState(() {
                      _race = val;
                      patientModel.race = val ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your race';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.race = val ?? '';
                  },
                  hintText: 'Select your race',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Health Metrics Section
  Widget _buildHealthMetricsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionComponents.buildSectionHeader(
            'Health Metrics',
            Icons.monitor_heart,
            Colors.red,
          ),
          const Gap(16),
          SectionComponents.buildSectionCard(
            borderColor: Colors.red,
            child: Column(
              children: [
                // Height and Weight Row
                Row(
                  children: [
                    Expanded(
                      child: SectionComponents.buildTextField(
                        label: 'Height (cm)',
                        controller: _heightController,
                        hintText: 'Enter your height',
                        prefixIcon: Icons.height,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your height';
                          }
                          final height = double.tryParse(value);
                          if (height == null || height <= 0 || height > 250) {
                            return 'Enter a valid height';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          patientModel.height =
                              (double.tryParse(val ?? '0') ?? 0).toInt();
                        },
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: SectionComponents.buildTextField(
                        label: 'Weight (kg)',
                        controller: _weightController,
                        hintText: 'Enter your weight',
                        prefixIcon: Icons.monitor_weight_outlined,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your weight';
                          }
                          final weight = double.tryParse(value);
                          if (weight == null || weight <= 0 || weight > 500) {
                            return 'Enter a valid weight';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          patientModel.weight =
                              (double.tryParse(val ?? '0') ?? 0).toInt();
                        },
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // BMI
                SectionComponents.buildTextField(
                  label: 'BMI',
                  controller: _bmiController,
                  hintText: 'Calculated automatically',
                  prefixIcon: Icons.calculate,
                  readOnly: true,
                  validator: (value) => null, // BMI is auto-calculated
                  onSaved: (val) {
                    patientModel.bmi = double.tryParse(val ?? '0') ?? 0;
                  },
                ),
                const Gap(16),

                // BMI Progress Indicator
                _buildBMIIndicator(),
                const Gap(16),

                // Heart Rate
                SectionComponents.buildTextField(
                  label: 'Heart Rate (bpm)',
                  controller: _heartRateController,
                  hintText: 'Enter your resting heart rate',
                  prefixIcon: Icons.favorite,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your heart rate';
                    }
                    final rate = int.tryParse(value);
                    if (rate == null || rate <= 0 || rate > 220) {
                      return 'Enter a valid heart rate';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.heartRate = int.tryParse(val ?? '0') ?? 0;
                  },
                ),
                const Gap(16),

                // Blood Type Dropdown
                SectionComponents.buildDropdownField<String>(
                  label: 'Blood Type',
                  value: _bloodType,
                  items: bloodTypes,
                  itemLabel: (item) => item,
                  onChanged: (val) {
                    setState(() {
                      _bloodType = val;
                      patientModel.bloodType = val ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your blood type';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.bloodType = val ?? '';
                  },
                  hintText: 'Select your blood type',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Health Conditions Section
  Widget _buildHealthConditionsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionComponents.buildSectionHeader(
            'Health Conditions',
            Icons.medical_services,
            Colors.teal,
          ),
          const Gap(16),
          SectionComponents.buildSectionCard(
            borderColor: Colors.teal,
            child: Column(
              children: [
                // Diabetes Status
                SectionComponents.buildDropdownField<String>(
                  label: 'Diabetic Status',
                  value: _diabetesStatus,
                  items: diabetesOptions,
                  itemLabel: (item) => item,
                  onChanged: (val) {
                    setState(() {
                      _diabetesStatus = val;
                      _diabetes = val == 'Yes';
                      patientModel.diabetic = val ?? 'No';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your diabetic status';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.diabetic = val ?? 'No';
                  },
                  hintText: 'Select your diabetic status',
                ),
                const Gap(16),

                // Chronic Condition
                SectionComponents.buildTextField(
                  label: 'Chronic Conditions (if any)',
                  controller: _chronicConditionController,
                  hintText: 'Enter any chronic conditions',
                  prefixIcon: Icons.medical_information,
                  maxLines: 3,
                  validator: (value) => null, // Optional field
                  onSaved: (val) {
                    patientModel.chronicCondition = val ?? '';
                  },
                ),
                const Gap(16),

                // Difficulty Walking
                SectionComponents.buildBooleanTile(
                  title: 'Difficulty Walking',
                  subtitle:
                      'Do you have serious difficulty walking or climbing stairs?',
                  value: _diffWalking,
                  onChanged: (val) {
                    setState(() {
                      _diffWalking = val;
                      patientModel.diffWalking = val;
                    });
                  },
                  icon: Icons.directions_walk,
                ),
                const Gap(10),

                // Asthma
                SectionComponents.buildBooleanTile(
                  title: 'Asthma',
                  subtitle: 'Do you have asthma?',
                  value: _asthma,
                  onChanged: (val) {
                    setState(() {
                      _asthma = val;
                      patientModel.asthma = val;
                    });
                  },
                  icon: Icons.air,
                ),
                const Gap(10),

                // Kidney Disease
                SectionComponents.buildBooleanTile(
                  title: 'Kidney Disease',
                  subtitle: 'Do you have kidney disease?',
                  value: _kidneyDisease,
                  onChanged: (val) {
                    setState(() {
                      _kidneyDisease = val;
                      patientModel.kidneyDisease = val;
                    });
                  },
                  icon: Icons.healing,
                ),
                const Gap(10),

                // Skin Cancer
                SectionComponents.buildBooleanTile(
                  title: 'Skin Cancer',
                  subtitle: 'Have you had skin cancer?',
                  value: _skinCancer,
                  onChanged: (val) {
                    setState(() {
                      _skinCancer = val;
                      patientModel.skinCancer = val;
                    });
                  },
                  icon: Icons.wb_sunny,
                ),
                const Gap(10),

                // Stroke
                SectionComponents.buildBooleanTile(
                  title: 'Stroke',
                  subtitle: 'Have you ever had a stroke?',
                  value: _stroke,
                  onChanged: (val) {
                    setState(() {
                      _stroke = val;
                      patientModel.stroke = val;
                    });
                  },
                  icon: Icons.psychology,
                ),
                const Gap(16),

                // Physical and Mental Health
                Row(
                  children: [
                    Expanded(
                      child: SectionComponents.buildTextField(
                        label: 'Physical Health (days/month)',
                        controller: _physicalHealthController,
                        hintText: '0-30',
                        prefixIcon: Icons.fitness_center,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final days = int.tryParse(value);
                            if (days == null || days < 0 || days > 30) {
                              return 'Enter a value between 0-30';
                            }
                          }
                          return null;
                        },
                        onSaved: (val) {
                          patientModel.physicalHealth =
                              int.tryParse(val ?? '0') ?? 0;
                        },
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: SectionComponents.buildTextField(
                        label: 'Mental Health (days/month)',
                        controller: _mentalHealthController,
                        hintText: '0-30',
                        prefixIcon: Icons.psychology_alt,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final days = int.tryParse(value);
                            if (days == null || days < 0 || days > 30) {
                              return 'Enter a value between 0-30';
                            }
                          }
                          return null;
                        },
                        onSaved: (val) {
                          patientModel.mentalHealth =
                              int.tryParse(val ?? '0') ?? 0;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Lifestyle Section
  Widget _buildLifestyleSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionComponents.buildSectionHeader(
            'Lifestyle',
            Icons.self_improvement,
            Colors.deepOrange,
          ),
          const Gap(16),
          SectionComponents.buildSectionCard(
            borderColor: Colors.deepOrange,
            child: Column(
              children: [
                // General Health Dropdown
                SectionComponents.buildDropdownField<String>(
                  label: 'General Health',
                  value: _genHealth,
                  items: genHealthOptions,
                  itemLabel: (item) => item,
                  onChanged: (val) {
                    setState(() {
                      _genHealth = val;
                      patientModel.genHealth = val ?? '';
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your general health';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.genHealth = val ?? '';
                  },
                  hintText: 'Rate your general health',
                ),
                const Gap(16),

                // Sleep Time
                SectionComponents.buildTextField(
                  label: 'Sleep Time (hours/day)',
                  controller: _sleepTimeController,
                  hintText: 'Enter average hours of sleep per day',
                  prefixIcon: Icons.bedtime,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      final hours = int.tryParse(value);
                      if (hours == null || hours < 0 || hours > 24) {
                        return 'Enter a value between 0-24';
                      }
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.sleepTime = int.tryParse(val ?? '0') ?? 0;
                  },
                ),
                const Gap(16),

                // Physical Activity
                SectionComponents.buildBooleanTile(
                  title: 'Physical Activity',
                  subtitle: 'Do you engage in regular physical activity?',
                  value: _physicalActivity,
                  onChanged: (val) {
                    setState(() {
                      _physicalActivity = val;
                      patientModel.physicalActivity = val;
                    });
                  },
                  icon: Icons.directions_run,
                ),
                const Gap(10),

                // Smoking
                SectionComponents.buildBooleanTile(
                  title: 'Smoking',
                  subtitle: 'Do you smoke?',
                  value: _smoking,
                  onChanged: (val) {
                    setState(() {
                      _smoking = val;
                      patientModel.smoking = val;
                    });
                  },
                  icon: Icons.smoking_rooms,
                ),
                const Gap(10),

                // Alcohol Drinking
                SectionComponents.buildBooleanTile(
                  title: 'Alcohol Consumption',
                  subtitle: 'Do you consume alcohol regularly?',
                  value: _alcoholDrinking,
                  onChanged: (val) {
                    setState(() {
                      _alcoholDrinking = val;
                      patientModel.alcoholDrinking = val;
                    });
                  },
                  icon: Icons.local_bar,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Validate and analyze
  void _validateAndAnalyze() {
    if (!_formKey.currentState!.validate()) {
      showCustomSnackBar(
        'Please fill in all required fields correctly.',
        context,
        isError: true,
      );
      return;
    }

    _formKey.currentState!.save();

    // First update the patient profile using the cubit
    context
        .read<GetProfileCubit>()
        .updatePatientProfile(patientModel: patientModel);

    // Create heart disease prediction request
    final HeartDiseasesRequest request = _createHeartDiseaseRequest();

    // Set request and trigger prediction
    context.read<PredictDiseaseCubit>().setRequest(request);
    context.read<PredictDiseaseCubit>().predictHeartDisease();

    showCustomSnackBar('Profile updated! Analyzing health data...', context);
  }
}
