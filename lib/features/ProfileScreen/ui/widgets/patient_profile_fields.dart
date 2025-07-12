import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/ProfileScreen/ui/views/private_profile_screen.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

import '../views/patient_edit_screen.dart';
import '../widgets/ProfileTextField.dart';
import 'medical_records_section.dart';

/// Widget for displaying patient-specific profile fields
class PatientProfileFields extends StatelessWidget {
  final PatientModel patient;
  final bool isEditing;
  final Map<String, TextEditingController> controllers;

  const PatientProfileFields({
    super.key,
    required this.patient,
    required this.isEditing,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Patient Profile Header with name and edit functionality
        Builder(builder: (context) {
          return PatientProfileHeaderWidget(
            name: patient.name,
            onEditPressed: () {
              // Navigate to patient edit screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PatientEditScreen(
                    patient: patient,
                    navigateToPrediction: false,
                  ),
                ),
              ).then((updatedPatient) {
                // Handle the returned updated patient if needed
                if (updatedPatient != null) {
                  // Find the nearest StatefulWidget ancestor and trigger a refresh
                  final PrivateProfileScreenState? parent = context
                      .findAncestorStateOfType<PrivateProfileScreenState>();
                  if (parent != null) {
                    // Trigger a refresh of the profile data
                    parent.setState(() {});
                  }
                }
              });
            },
            isEditing: isEditing,
          );
        }),

        const SizedBox(height: 20),

        // Basic Health Information
        _buildSectionHeader(
            'Basic Health Information', Icons.health_and_safety),
        _buildBasicHealthFields(),

        const SizedBox(height: 12),

        // Detailed Health Metrics
        _buildSectionHeader('Detailed Health Metrics', Icons.analytics),
        _buildDetailedHealthFields(),

        const SizedBox(height: 12),

        // Medical History
        _buildSectionHeader('Medical History', Icons.history),
        _buildMedicalHistoryFields(),

        const SizedBox(height: 12),

        const MedicalRecordsSection(),
        const SizedBox(height: 12),

        // Diagnosis Data Section
        DiagnosisDataSection(patient: patient),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: AppStyles.semiBold16.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicHealthFields() {
    return Column(
      children: [
        ProfileTextField(
          label: "Blood Type",
          controller: controllers['bloodType']!,
          icon: Icons.bloodtype,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Height (cm)",
          controller: controllers['height']!,
          icon: Icons.height,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Weight (kg)",
          controller: controllers['weight']!,
          icon: Icons.monitor_weight,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "BMI",
          controller: controllers['bmi']!,
          icon: Icons.monitor_weight,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Heart Rate (bpm)",
          controller: controllers['heartRate']!,
          icon: Icons.favorite,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Date of Birth",
          controller: controllers['dob']!,
          icon: Icons.cake,
          enabled: isEditing,
        ),
      ],
    );
  }

  Widget _buildDetailedHealthFields() {
    return Column(
      children: [
        ProfileTextField(
          label: "Physical Health (1-30)",
          controller: controllers['physicalHealth']!,
          icon: Icons.fitness_center,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Mental Health (1-30)",
          controller: controllers['mentalHealth']!,
          icon: Icons.psychology,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "General Health",
          controller: controllers['genHealth']!,
          icon: Icons.health_and_safety,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Sleep Time (hours)",
          controller: controllers['sleepTime']!,
          icon: Icons.bedtime,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Age Category",
          controller: controllers['ageCategory']!,
          icon: Icons.cake,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Race",
          controller: controllers['race']!,
          icon: Icons.people,
          enabled: isEditing,
        ),
      ],
    );
  }

  Widget _buildMedicalHistoryFields() {
    return Column(
      children: [
        ProfileTextField(
          label: "Chronic Conditions",
          controller: controllers['chronic']!,
          icon: Icons.medical_services,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Diabetic Status",
          controller: controllers['diabetic']!,
          icon: Icons.medical_information,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Physical Activity",
          controller: controllers['physicalActivity']!,
          icon: Icons.directions_run,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Difficulty Walking",
          controller: controllers['diffWalking']!,
          icon: Icons.accessible,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Smoking",
          controller: controllers['smoking']!,
          icon: Icons.smoking_rooms,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Alcohol Drinking",
          controller: controllers['alcoholDrinking']!,
          icon: Icons.local_bar,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Stroke History",
          controller: controllers['stroke']!,
          icon: Icons.emergency,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Asthma",
          controller: controllers['asthma']!,
          icon: Icons.air,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Kidney Disease",
          controller: controllers['kidneyDisease']!,
          icon: Icons.medical_services,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Skin Cancer",
          controller: controllers['skinCancer']!,
          icon: Icons.health_and_safety,
          enabled: isEditing,
        ),
      ],
    );
  }
}

/// Widget for displaying diagnosis data in a grid layout
class DiagnosisDataSection extends StatelessWidget {
  final PatientModel patient;

  const DiagnosisDataSection({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(12),
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

  Widget _buildDiagnosisDataGrid() {
    final diagnosisData = _getDiagnosisData();

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(8),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
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

  List<Map<String, dynamic>> _getDiagnosisData() {
    return [
      {
        'label': 'BMI',
        'value': patient.bmi.toString(),
        'icon': Icons.monitor_weight,
        'color': Colors.cyan
      },
      {
        'label': 'Smoking',
        'value': patient.smoking ? 'Yes' : 'No',
        'icon': Icons.smoking_rooms,
        'color': Colors.red
      },
      {
        'label': 'Alcohol Drinking',
        'value': patient.alcoholDrinking ? 'Yes' : 'No',
        'icon': Icons.local_bar,
        'color': Colors.red
      },
      {
        'label': 'Stroke',
        'value': patient.stroke ? 'Yes' : 'No',
        'icon': Icons.emergency,
        'color': Colors.red
      },
      {
        'label': 'Physical Health',
        'value': '${patient.physicalHealth}/30',
        'icon': Icons.fitness_center,
        'color': Colors.blue
      },
      {
        'label': 'Mental Health',
        'value': '${patient.mentalHealth}/30',
        'icon': Icons.psychology,
        'color': Colors.blue
      },
      {
        'label': 'Difficulty Walking',
        'value': patient.diffWalking ? 'Yes' : 'No',
        'icon': Icons.accessible,
        'color': Colors.red
      },
      {
        'label': 'Sex',
        'value': patient.gender,
        'icon': Icons.person,
        'color': Colors.cyan
      },
      {
        'label': 'Age Category',
        'value': patient.ageCategory,
        'icon': Icons.cake,
        'color': Colors.blue
      },
      {
        'label': 'Race',
        'value': patient.race,
        'icon': Icons.people,
        'color': Colors.blue
      },
      {
        'label': 'Diabetic',
        'value': patient.diabetic,
        'icon': Icons.medical_information,
        'color': Colors.red
      },
      {
        'label': 'Physical Activity',
        'value': patient.physicalActivity ? 'Yes' : 'No',
        'icon': Icons.directions_run,
        'color': Colors.cyan
      },
      {
        'label': 'General Health',
        'value': patient.genHealth,
        'icon': Icons.health_and_safety,
        'color': Colors.blue
      },
      {
        'label': 'Sleep Time',
        'value': '${patient.sleepTime} hours',
        'icon': Icons.bedtime,
        'color': Colors.cyan
      },
      {
        'label': 'Asthma',
        'value': patient.asthma ? 'Yes' : 'No',
        'icon': Icons.air,
        'color': Colors.cyan
      },
      {
        'label': 'Kidney Disease',
        'value': patient.kidneyDisease ? 'Yes' : 'No',
        'icon': Icons.medical_services,
        'color': Colors.red
      },
      {
        'label': 'Skin Cancer',
        'value': patient.skinCancer ? 'Yes' : 'No',
        'icon': Icons.health_and_safety,
        'color': Colors.cyan
      },
    ];
  }

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
}

/// Header widget for patient profile section - name and edit functionality without image
class PatientProfileHeaderWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onEditPressed;
  final bool isEditing;

  const PatientProfileHeaderWidget({
    super.key,
    required this.name,
    this.onEditPressed,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
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
      child: Container(
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
                Icons.person,
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
                    name,
                    style: AppStyles.semiBold18.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Patient Profile',
                    style: AppStyles.regular12.copyWith(
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            if (onEditPressed != null)
              GestureDetector(
                onTap: onEditPressed,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isEditing ? Icons.check : Icons.edit,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
