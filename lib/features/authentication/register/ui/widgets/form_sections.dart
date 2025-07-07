import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/register/ui/widgets/section_components.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../data/models/patient_model.dart';

/// Class that contains methods to build different form sections for patient registration
class FormSections {
  /// Builds the basic information section
  static Widget buildBasicInfoSection({
    required PatientModel patientModel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionComponents.buildSectionHeader(
          'Basic Information',
          Icons.person,
          AppColors.secondaryColor,
        ),
        const Gap(16),
        SectionComponents.buildSectionCard(
          child: Column(
            children: [
              // Full Name
              SectionComponents.buildTextField(
                label: 'Full Name',
                controller: null,
                hintText: 'Enter your full name',
                prefixIcon: Icons.person_outline_rounded,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.name = val ?? '';
                },
              ),
              const Gap(16),

              // Email & Username Row
              Row(
                children: [
                  Expanded(
                    child: SectionComponents.buildTextField(
                      label: 'Email',
                      controller: null,
                      hintText: 'Enter your email',
                      prefixIcon: Icons.email_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.email = val ?? '';
                      },
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: SectionComponents.buildTextField(
                      label: 'Username',
                      controller: null,
                      hintText: 'Enter your username',
                      prefixIcon: Icons.person_pin_outlined,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.username = val ?? '';
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),

              // Password
              SectionComponents.buildTextField(
                label: 'Password',
                controller: null,
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.password = val ?? '';
                },
              ),
            ],
          ),
          borderColor: AppColors.secondaryColor,
        ),
      ],
    );
  }

  /// Builds the personal details section
  static Widget buildPersonalDetailsSection({
    required PatientModel patientModel,
    required String? gender,
    required ValueChanged<String?> onGenderChanged,
    required TextEditingController dateOfBirthController,
    required VoidCallback onSelectDate,
    required String? bloodType,
    required ValueChanged<String?> onBloodTypeChanged,
    required List<String> bloodTypes,
    required String? ageCategory,
    required ValueChanged<String?> onAgeCategoryChanged,
    required List<String> ageCategoryOptions,
    required String? race,
    required ValueChanged<String?> onRaceChanged,
    required List<String> raceOptions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionComponents.buildSectionHeader(
          'Personal Details',
          Icons.badge,
          Colors.blue,
        ),
        const Gap(16),
        SectionComponents.buildSectionCard(
          child: Column(
            children: [
              // Gender & Date of Birth Row
              Row(
                children: [
                  Expanded(
                    child: SectionComponents.buildDropdownField<String>(
                      label: 'Gender',
                      value: gender,
                      items: ['male', 'female'],
                      itemLabel: (item) => item.toUpperCase(),
                      hintText: 'Select gender',
                      onChanged: onGenderChanged,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your gender';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.gender = val ?? 'male';
                      },
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: SectionComponents.buildTextField(
                      label: 'Date of Birth',
                      controller: dateOfBirthController,
                      hintText: 'Select date of birth',
                      prefixIcon: Icons.calendar_today,
                      readOnly: true,
                      onTap: onSelectDate,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select date of birth';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.dateOfBirth = val ?? '';
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),

              // Blood Type
              SectionComponents.buildDropdownField<String>(
                label: 'Blood Type',
                value: bloodType,
                items: bloodTypes,
                itemLabel: (item) => item,
                hintText: 'Select blood type',
                onChanged: onBloodTypeChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your blood type';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.bloodType = val ?? '';
                },
              ),
              const Gap(10),

              // Age Category
              SectionComponents.buildDropdownField<String>(
                label: 'Age Category',
                value: ageCategory,
                items: ageCategoryOptions,
                itemLabel: (item) => item,
                hintText: 'Select age category',
                onChanged: onAgeCategoryChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your age category';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.ageCategory = val ?? '';
                },
              ),
              const Gap(16),

              // Race
              SectionComponents.buildDropdownField<String>(
                label: 'Race',
                value: race,
                items: raceOptions,
                itemLabel: (item) => item,
                hintText: 'Select race',
                onChanged: onRaceChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your race';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.race = val ?? '';
                },
              ),
            ],
          ),
          borderColor: Colors.blue,
        ),
      ],
    );
  }
  
  /// Builds the health metrics section
  static Widget buildHealthMetricsSection({
    required PatientModel patientModel,
    required TextEditingController heightController,
    required TextEditingController weightController,
    required TextEditingController bmiController,
    required Widget bmiProgressIndicator,
    required TextEditingController heartRateController,
    required String? genHealth,
    required ValueChanged<String?> onGenHealthChanged,
    required List<String> genHealthOptions,
    required TextEditingController chronicConditionController,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionComponents.buildSectionHeader(
          'Health Metrics',
          Icons.monitor_heart,
          Colors.green,
        ),
        const Gap(16),
        SectionComponents.buildSectionCard(
          child: Column(
            children: [
              // Height & Weight Row
              Row(
                children: [
                  Expanded(
                    child: SectionComponents.buildTextField(
                      label: 'Height (cm)',
                      controller: heightController,
                      hintText: 'Enter height in cm',
                      prefixIcon: Icons.height,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        final height = double.tryParse(value);
                        if (height == null || height <= 0) {
                          return 'Please enter a valid height';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.height = int.tryParse(val ?? '0') ?? 0;
                      },
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: SectionComponents.buildTextField(
                      label: 'Weight (kg)',
                      controller: weightController,
                      hintText: 'Enter weight in kg',
                      prefixIcon: Icons.monitor_weight,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        final weight = double.tryParse(value);
                        if (weight == null || weight <= 0) {
                          return 'Please enter a valid weight';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.weight = int.tryParse(val ?? '0') ?? 0;
                      },
                    ),
                  ),
                ],
              ),
              const Gap(16),

              // BMI Field
              SectionComponents.buildTextField(
                label: 'BMI (Body Mass Index)',
                controller: bmiController,
                hintText: 'Auto-calculated from height and weight',
                prefixIcon: Icons.calculate,
                readOnly: true,
                filled: true,
                fillColor: Colors.grey[100],
                onSaved: (val) {
                  patientModel.bmi = double.tryParse(val ?? '0') ?? 0.0;
                },
                validator: null,
              ),
              const Gap(16),

              // BMI Progress Indicator
              bmiProgressIndicator,
              const Gap(16),

              // Heart Rate
              SectionComponents.buildTextField(
                label: 'Heart Rate (bpm)',
                controller: heartRateController,
                hintText: 'Enter heart rate in bpm',
                prefixIcon: Icons.favorite,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final heartRate = int.tryParse(value);
                    if (heartRate == null || heartRate <= 0) {
                      return 'Please enter a valid heart rate';
                    }
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.heartRate = int.tryParse(val ?? '0') ?? 0;
                },
              ),
              const Gap(16),

              // Physical Health & Mental Health
              SectionComponents.buildTextField(
                label: 'Physical Health (1-30)',
                controller: null,
                hintText: 'Days of poor physical health',
                prefixIcon: Icons.fitness_center,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final days = int.tryParse(value);
                    if (days == null || days < 0 || days > 30) {
                      return 'Enter value between 0-30';
                    }
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.physicalHealth = int.tryParse(val ?? '0') ?? 0;
                },
              ),
              const Gap(16),
              
              SectionComponents.buildTextField(
                label: 'Mental Health (1-30)',
                controller: null,
                hintText: 'Days of poor mental health',
                prefixIcon: Icons.psychology,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final days = int.tryParse(value);
                    if (days == null || days < 0 || days > 30) {
                      return 'Enter value between 0-30';
                    }
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.mentalHealth = int.tryParse(val ?? '0') ?? 0;
                },
              ),
              const Gap(16),

              // General Health & Sleep Time
              SectionComponents.buildDropdownField<String>(
                label: 'General Health',
                value: genHealth,
                items: genHealthOptions,
                itemLabel: (item) => item,
                hintText: 'Select general health',
                onChanged: onGenHealthChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select general health';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.genHealth = val ?? '';
                },
              ),
              const Gap(16),
              
              SectionComponents.buildTextField(
                label: 'Sleep Time (hours)',
                controller: null,
                hintText: 'Hours of sleep per night',
                prefixIcon: Icons.bedtime,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final hours = int.tryParse(value);
                    if (hours == null || hours < 0 || hours > 24) {
                      return 'Enter value between 0-24';
                    }
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.sleepTime = int.tryParse(val ?? '0') ?? 0;
                },
              ),
              const Gap(16),

              // Chronic Condition
              SectionComponents.buildTextField(
                label: 'Chronic Condition',
                controller: chronicConditionController,
                hintText: 'Enter any chronic conditions',
                prefixIcon: Icons.medical_services,
                maxLines: 2,
                onSaved: (val) {
                  patientModel.chronicCondition = val ?? '';
                },
                validator: null,
              ),
            ],
          ),
          borderColor: Colors.green,
        ),
      ],
    );
  }

  /// Builds the medical history section
  static Widget buildMedicalHistorySection({
    required PatientModel patientModel,
    required String? diabetesStatus,
    required ValueChanged<String?> onDiabetesChanged,
    required List<String> diabetesOptions,
    required bool smoking,
    required ValueChanged<bool> onSmokingChanged,
    required bool alcoholDrinking,
    required ValueChanged<bool> onAlcoholChanged,
    required bool stroke,
    required ValueChanged<bool> onStrokeChanged,
    required bool diffWalking,
    required ValueChanged<bool> onDiffWalkingChanged,
    required bool physicalActivity,
    required ValueChanged<bool> onPhysicalActivityChanged,
    required bool asthma,
    required ValueChanged<bool> onAsthmaChanged,
    required bool kidneyDisease,
    required ValueChanged<bool> onKidneyDiseaseChanged,
    required bool skinCancer,
    required ValueChanged<bool> onSkinCancerChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionComponents.buildSectionHeader(
          'Medical History',
          Icons.local_hospital,
          Colors.orange,
        ),
        const Gap(16),
        SectionComponents.buildSectionCard(
          child: Column(
            children: [
              // Diabetes Status
              SectionComponents.buildDropdownField<String>(
                label: 'Diabetes Status',
                value: diabetesStatus,
                items: diabetesOptions,
                itemLabel: (item) => item,
                hintText: 'Select diabetes status',
                onChanged: onDiabetesChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select diabetes status';
                  }
                  return null;
                },
                onSaved: (val) {
                  patientModel.diabetic = val ?? 'No';
                  patientModel.diabetes = val == 'Yes';
                },
              ),
              const Gap(20),

              // Medical Conditions - Boolean Fields
              SectionComponents.buildSectionSubtitle('Medical Conditions', Colors.orange),
              const Gap(12),

              SectionComponents.buildBooleanTile(
                title: 'Smoking',
                subtitle: 'Do you smoke or have you smoked?',
                value: smoking,
                onChanged: onSmokingChanged,
                icon: Icons.smoking_rooms,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Alcohol Drinking',
                subtitle: 'Do you drink alcohol regularly?',
                value: alcoholDrinking,
                onChanged: onAlcoholChanged,
                icon: Icons.local_bar,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Stroke',
                subtitle: 'Have you ever had a stroke?',
                value: stroke,
                onChanged: onStrokeChanged,
                icon: Icons.healing,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Difficulty Walking',
                subtitle: 'Do you have difficulty walking or climbing stairs?',
                value: diffWalking,
                onChanged: onDiffWalkingChanged,
                icon: Icons.accessibility,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Physical Activity',
                subtitle: 'Do you engage in regular physical activity?',
                value: physicalActivity,
                onChanged: onPhysicalActivityChanged,
                icon: Icons.fitness_center,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Asthma',
                subtitle: 'Do you have asthma?',
                value: asthma,
                onChanged: onAsthmaChanged,
                icon: Icons.air,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Kidney Disease',
                subtitle: 'Do you have kidney disease?',
                value: kidneyDisease,
                onChanged: onKidneyDiseaseChanged,
                icon: Icons.medical_services,
              ),

              SectionComponents.buildBooleanTile(
                title: 'Skin Cancer',
                subtitle: 'Do you have skin cancer?',
                value: skinCancer,
                onChanged: onSkinCancerChanged,
                icon: Icons.spa,
              ),
            ],
          ),
          borderColor: Colors.orange,
        ),
      ],
    );
  }
  
  /// Builds terms and conditions checkbox
  static Widget buildTermsAndConditions({
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
    required Color activeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: CheckboxListTile(
        title: const Text(
          'I agree to the Terms and Conditions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        value: isChecked,
        onChanged: onChanged,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: activeColor,
      ),
    );
  }
}
