import 'package:flutter/material.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

class SimplePatientProfileScreen extends StatelessWidget {
  final PatientModel patient;

  const SimplePatientProfileScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              expandedHeight: 200,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  patient.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                background: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/profilebackground2png.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Patient Avatar and Basic Info
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      patient.name,
                      style: AppStyles.semiBold24.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      patient.email,
                      style: AppStyles.regular14.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Basic Information Section
              _buildSectionHeader('Basic Information'),
              const SizedBox(height: 16),
              _buildInfoCard([
                _buildInfoRow('Username', patient.username),
                _buildInfoRow('Gender', patient.gender),
                _buildInfoRow('Date of Birth', patient.dateOfBirth),
                _buildInfoRow('Blood Type', patient.bloodType),
              ]),

              const SizedBox(height: 24),

              // Health Information Section
              _buildSectionHeader('Health Information'),
              const SizedBox(height: 16),
              _buildInfoCard([
                _buildInfoRow('BMI', patient.bmi.toString()),
                _buildInfoRow('Heart Rate', '${patient.heartRate} bpm'),
                if (patient.height != null)
                  _buildInfoRow('Height', '${patient.height} cm'),
                if (patient.weight != null)
                  _buildInfoRow('Weight', '${patient.weight} kg'),
                _buildInfoRow(
                    'Physical Health Score', '${patient.physicalHealth}/30'),
                _buildInfoRow(
                    'Mental Health Score', '${patient.mentalHealth}/30'),
              ]),

              const SizedBox(height: 24),

              // Lifestyle Section
              _buildSectionHeader('Lifestyle'),
              const SizedBox(height: 16),
              _buildInfoCard([
                _buildInfoRow('General Health', patient.genHealth),
                _buildInfoRow('Sleep Time', '${patient.sleepTime} hours'),
                _buildInfoRow('Age Category', patient.ageCategory),
                _buildInfoRow('Race', patient.race),
                _buildInfoRow('Diabetic Status', patient.diabetic),
              ]),

              const SizedBox(height: 24),

              // Health Conditions Section
              _buildSectionHeader('Health Conditions'),
              const SizedBox(height: 16),
              _buildInfoCard([
                _buildBooleanRow('Smoking', patient.smoking),
                _buildBooleanRow('Alcohol Drinking', patient.alcoholDrinking),
                _buildBooleanRow('Stroke History', patient.stroke),
                _buildBooleanRow('Physical Activity', patient.physicalActivity),
                _buildBooleanRow('Difficulty Walking', patient.diffWalking),
                _buildBooleanRow('Asthma', patient.asthma),
                _buildBooleanRow('Kidney Disease', patient.kidneyDisease),
                _buildBooleanRow('Skin Cancer', patient.skinCancer),
              ]),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppStyles.semiBold18.copyWith(
        color: AppColors.primaryColor,
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.medium14.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: AppStyles.semiBold14.copyWith(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooleanRow(String label, bool value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: AppStyles.medium14.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Icon(
                  value ? Icons.check_circle : Icons.cancel,
                  color: value ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  value ? 'Yes' : 'No',
                  style: AppStyles.semiBold14.copyWith(
                    color: value ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
