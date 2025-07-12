import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

class ModernPatientProfileScreen extends StatelessWidget {
  final PatientModel patient;

  const ModernPatientProfileScreen({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: false,
              elevation: 0,
              expandedHeight: 240,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.primaryColor,
                        AppColors.primaryColor.withOpacity(0.8),
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Background pattern
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                            image: DecorationImage(
                              image: const AssetImage(
                                  'assets/images/profilebackground2png.png'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                AppColors.primaryColor.withOpacity(0.7),
                                BlendMode.overlay,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Content
                      Positioned(
                        bottom: 40,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    AppColors.primaryColor.withOpacity(0.1),
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              patient.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              patient.email,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              leading: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              // actions: [
              //   Container(
              //     margin: const EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       color: Colors.white.withOpacity(0.2),
              //       borderRadius: BorderRadius.circular(12),
              //     ),
              //     child: IconButton(
              //       icon: const Icon(Icons.edit, color: Colors.white),
              //       onPressed: () {},
              //     ),
              //   ),
              // ],
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quick Stats Cards
              _buildQuickStatsRow(),
              const SizedBox(height: 24),

              // Basic Information Section
              _buildModernSection(
                'Basic Information',
                Icons.person_outline,
                _buildBasicInfoGrid(),
              ),

              const SizedBox(height: 20),

              // Health Metrics Section
              _buildModernSection(
                'Health Metrics',
                Icons.monitor_heart_outlined,
                _buildHealthMetricsGrid(),
              ),

              const SizedBox(height: 20),

              // Lifestyle Section
              _buildModernSection(
                'Lifestyle',
                Icons.psychology_outlined,
                _buildLifestyleGrid(),
              ),

              const SizedBox(height: 20),

              // Health Conditions Section
              _buildModernSection(
                'Health Conditions',
                Icons.medical_information_outlined,
                _buildConditionsGrid(),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'BMI',
            patient.bmi.toString(),
            Icons.monitor_weight_outlined,
            _getBMIColor(patient.bmi),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Heart Rate',
            '${patient.heartRate}',
            Icons.favorite_outline,
            Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            'Sleep',
            '${patient.sleepTime}h',
            Icons.bedtime_outlined,
            Colors.indigo,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSection(String title, IconData icon, Widget content) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: AppStyles.semiBold18.copyWith(
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          content,
        ],
      ),
    );
  }

  Widget _buildBasicInfoGrid() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: _buildInfoTile('Gender', patient.gender)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoTile('Race', patient.race)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoTile(
                    'Birth Date', _formatDate(patient.dateOfBirth)),
              ),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoTile('Blood Type', patient.bloodType)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildInfoTile(
                    'Age', _getAgeFromDateOfBirth(patient.dateOfBirth)),
              ),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoTile('Username', patient.username)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetricsGrid() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          if (patient.height != null && patient.weight != null) ...[
            Row(
              children: [
                Expanded(
                    child: _buildInfoTile('Height', '${patient.height} cm')),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildInfoTile('Weight', '${patient.weight} kg')),
              ],
            ),
            const SizedBox(height: 12),
          ],
          Row(
            children: [
              Expanded(
                child: _buildScoreTile(
                  'Physical Health',
                  patient.physicalHealth,
                  30,
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScoreTile(
                  'Mental Health',
                  patient.mentalHealth,
                  30,
                  Colors.purple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLifestyleGrid() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: _buildInfoTile('General Health', patient.genHealth)),
              const SizedBox(width: 12),
              Expanded(
                  child: _buildInfoTile('Age Category', patient.ageCategory)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildInfoTile('Race', patient.race)),
              const SizedBox(width: 12),
              Expanded(child: _buildInfoTile('Diabetic', patient.diabetic)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConditionsGrid() {
    final conditions = [
      ('Smoking', patient.smoking),
      ('Alcohol', patient.alcoholDrinking),
      ('Stroke History', patient.stroke),
      ('Physical Activity', patient.physicalActivity),
      ('Difficulty Walking', patient.diffWalking),
      ('Asthma', patient.asthma),
      ('Kidney Disease', patient.kidneyDisease),
      ('Skin Cancer', patient.skinCancer),
    ];

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: conditions.length,
        itemBuilder: (context, index) {
          final condition = conditions[index];
          return _buildConditionTile(condition.$1, condition.$2);
        },
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreTile(String label, int score, int maxScore, Color color) {
    double percentage = score / maxScore;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '$score/$maxScore',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const Spacer(),
              Text(
                '${(percentage * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionTile(String label, bool value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: value
            ? Colors.green.withOpacity(0.05)
            : Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value
              ? Colors.green.withOpacity(0.2)
              : Colors.red.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: value ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              value ? Icons.check : Icons.close,
              color: Colors.white,
              size: 12,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: value ? Colors.green[700] : Colors.red[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to format dates
  String _formatDate(String dateString) {
    try {
      // Try to parse the date string
      DateTime date;

      // Handle different possible date formats
      if (dateString.contains('/')) {
        // Format: MM/dd/yyyy or dd/MM/yyyy
        final parts = dateString.split('/');
        if (parts.length == 3) {
          // Assume MM/dd/yyyy format
          date = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[0]), // month
            int.parse(parts[1]), // day
          );
        } else {
          return dateString; // Return original if parsing fails
        }
      } else if (dateString.contains('-')) {
        // Format: yyyy-MM-dd
        date = DateTime.parse(dateString);
      } else {
        return dateString; // Return original if format is unknown
      }

      // Format the date nicely
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      // If parsing fails, return the original string
      return dateString;
    }
  }

  // Helper method to calculate age from date of birth
  String _getAgeFromDateOfBirth(String dateOfBirth) {
    try {
      DateTime birthDate;

      if (dateOfBirth.contains('/')) {
        final parts = dateOfBirth.split('/');
        if (parts.length == 3) {
          birthDate = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[0]), // month
            int.parse(parts[1]), // day
          );
        } else {
          return '';
        }
      } else if (dateOfBirth.contains('-')) {
        birthDate = DateTime.parse(dateOfBirth);
      } else {
        return '';
      }

      final now = DateTime.now();
      int age = now.year - birthDate.year;

      // Adjust age if birthday hasn't occurred this year
      if (now.month < birthDate.month ||
          (now.month == birthDate.month && now.day < birthDate.day)) {
        age--;
      }

      return '$age years old';
    } catch (e) {
      return '';
    }
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.blue;
    if (bmi < 25) return Colors.green;
    if (bmi < 30) return Colors.orange;
    return Colors.red;
  }
}
