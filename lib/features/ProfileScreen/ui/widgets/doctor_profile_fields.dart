import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/ProfileScreen/ui/views/private_profile_screen.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';

import '../widgets/ProfileTextField.dart';
import '../widgets/doctor_profile_picture_section.dart';
import '../widgets/doctor_verification_section.dart';
import '../widgets/medical_records_section.dart';

/// Widget for displaying doctor-specific profile fields
class DoctorProfileFields extends StatelessWidget {
  final DoctorModel doctor;
  final bool isEditing;
  final Map<String, TextEditingController> controllers;

  const DoctorProfileFields({
    super.key,
    required this.doctor,
    required this.isEditing,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile Picture Section with name and edit functionality
        Builder(builder: (context) {
          return DoctorProfilePictureSection(
            doctor: doctor,
            isEditing: isEditing,
            onEditPressed: () {
              // Find the nearest StatefulWidget ancestor and toggle editing state
              final PrivateProfileScreenState? parent =
                  context.findAncestorStateOfType<PrivateProfileScreenState>();
              if (parent != null) {
                parent.toggleEditing();
              }
            },
          );
        }),

        const SizedBox(height: 20),

        // Professional Information
        _buildSectionHeader('Professional Information', Icons.work),
        _buildProfessionalFields(),

        const SizedBox(height: 20),

        // Contact & Location
        _buildSectionHeader('Contact & Location', Icons.location_on),
        _buildContactFields(),

        const SizedBox(height: 20),

        // Doctor Verification Section
        DoctorVerificationSection(doctor: doctor),

        // Medical Records Section
        const MedicalRecordsSection(),
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

  Widget _buildProfessionalFields() {
    return Column(
      children: [
        ProfileTextField(
          label: "Specialization",
          controller: controllers['specialization']!,
          icon: Icons.work,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Experience Years",
          controller: controllers['experienceYears']!,
          icon: Icons.history,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Rating",
          controller: controllers['rating']!,
          icon: Icons.star,
          enabled: false,
        ),
        ProfileTextField(
          label: "Clinic Name",
          controller: controllers['clinicName']!,
          icon: Icons.local_hospital,
          enabled: isEditing,
        ),
      ],
    );
  }

  Widget _buildContactFields() {
    return Column(
      children: [
        ProfileTextField(
          label: "Phone",
          controller: controllers['phone']!,
          icon: Icons.phone,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Nationality",
          controller: controllers['nationality']!,
          icon: Icons.flag,
          enabled: isEditing,
        ),
        ProfileTextField(
          label: "Clinic Address",
          controller: controllers['clinicAddress']!,
          icon: Icons.location_on,
          enabled: isEditing,
        ),
      ],
    );
  }
}
