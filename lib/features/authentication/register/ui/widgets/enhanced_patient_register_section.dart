import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/register/ui/widgets/register_navigation_section.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';
import '../../data/models/patient_model.dart';
import '../cubit/register_cubit/register_cubit.dart';

class EnhancedPatientRegisterSection extends StatefulWidget {
  const EnhancedPatientRegisterSection({super.key});

  @override
  State<EnhancedPatientRegisterSection> createState() =>
      _EnhancedPatientRegisterSectionState();
}

class _EnhancedPatientRegisterSectionState
    extends State<EnhancedPatientRegisterSection> {
  bool _isChecked = false;

  // Initialize PatientModel with both old and new structure
  PatientModel patientModel = PatientModel(
    name: '',
    email: '',
    username: '',
    password: '',
    role: 'patient',
    gender: 'male',
    dateOfBirth: '',
    bloodType: '',
    // Old fields
    height: 0,
    weight: 0,
    chronicCondition: '',
    diabetes: false,
    heartRate: 0,
    // New fields
    bmi: 0.0,
    smoking: false,
    alcoholDrinking: false,
    stroke: false,
    physicalHealth: 0,
    mentalHealth: 0,
    diffWalking: false,
    ageCategory: '',
    race: '',
    diabetic: 'No',
    physicalActivity: false,
    genHealth: '',
    sleepTime: 0,
    asthma: false,
    kidneyDisease: false,
    skinCancer: false,
  );

  // Dropdown values
  String? _bloodType;
  String? _diabetesStatus;
  String? _gender;
  String? _ageCategory;
  String? _race;
  String? _genHealth;
  bool _physicalActivity = false;
  bool _diffWalking = false;
  bool _asthma = false;
  bool _kidneyDisease = false;
  bool _skinCancer = false;
  bool _smoking = false;
  bool _alcoholDrinking = false;
  bool _stroke = false;

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
  final List<String> diabetesOptions = ['Yes', 'No', 'Borderline'];
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
    'Native American',
    'Other'
  ];
  final List<String> genHealthOptions = [
    'Excellent',
    'Very Good',
    'Good',
    'Fair',
    'Poor'
  ];

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for Date of Birth field
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _gender = 'male';
    _physicalActivity = false;
    _diffWalking = false;
    _asthma = false;
    _kidneyDisease = false;
    _skinCancer = false;
    _smoking = false;
    _alcoholDrinking = false;
    _stroke = false;
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

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const Gap(8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Basic Information Section
          _buildSectionHeader(
              'Basic Information', Icons.person, AppColors.secondaryColor),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Column(
              children: [
                // Full Name
                const CustomTextfieldLabel(label: 'Full Name'),
                const Gap(5),
                CustomTextField(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Email'),
                          const Gap(5),
                          CustomTextField(
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
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Username'),
                          const Gap(5),
                          CustomTextField(
                            hintText: 'Enter your username',
                            prefixIcon: Icons.person_outline_rounded,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Password
                const CustomTextfieldLabel(label: 'Password'),
                const Gap(5),
                CustomTextField(
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline_rounded,
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
          ),
          const Gap(24),

          // Personal Details Section
          _buildSectionHeader('Personal Details', Icons.badge, Colors.blue),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              children: [
                // Gender & Date of Birth Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Gender'),
                          const Gap(5),
                          DropdownButtonFormField<String>(
                            value: _gender,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            items: genderOptions.map((String gender) {
                              return DropdownMenuItem<String>(
                                value: gender,
                                child: Text(gender.toUpperCase()),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _gender = value;
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
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Date of Birth'),
                          const Gap(5),
                          TextFormField(
                            controller: _dateOfBirthController,
                            decoration: InputDecoration(
                              hintText: 'Select date of birth',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                            readOnly: true,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Blood Type & Age Category Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Blood Type'),
                          const Gap(5),
                          DropdownButtonFormField<String>(
                            value: _bloodType,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            items: bloodTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _bloodType = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select blood type';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.bloodType = val ?? '';
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Age Category'),
                          const Gap(5),
                          DropdownButtonFormField<String>(
                            value: _ageCategory,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            items: ageCategoryOptions.map((String category) {
                              return DropdownMenuItem<String>(
                                value: category,
                                child: Text(category),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _ageCategory = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select age category';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.ageCategory = val ?? '';
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Race
                const CustomTextfieldLabel(label: 'Race'),
                const Gap(5),
                DropdownButtonFormField<String>(
                  value: _race,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  items: raceOptions.map((String race) {
                    return DropdownMenuItem<String>(
                      value: race,
                      child: Text(race),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _race = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select race';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.race = val ?? '';
                  },
                ),
              ],
            ),
          ),
          const Gap(24),

          // Physical Health Section
          _buildSectionHeader(
              'Physical Health', Icons.fitness_center, Colors.green),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              children: [
                // Height & Weight Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Height (cm)'),
                          const Gap(5),
                          CustomTextField(
                            hintText: 'Enter height',
                            prefixIcon: Icons.height,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter height';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.height =
                                  int.tryParse(val ?? '0') ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Weight (kg)'),
                          const Gap(5),
                          CustomTextField(
                            hintText: 'Enter weight',
                            prefixIcon: Icons.monitor_weight,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter weight';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.weight =
                                  int.tryParse(val ?? '0') ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // BMI & Heart Rate Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'BMI'),
                          const Gap(5),
                          CustomTextField(
                            hintText: 'Enter BMI',
                            prefixIcon: Icons.monitor_weight,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter BMI';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.bmi =
                                  double.tryParse(val ?? '0') ?? 0.0;
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Heart Rate (bpm)'),
                          const Gap(5),
                          CustomTextField(
                            hintText: 'Enter heart rate',
                            prefixIcon: Icons.favorite,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter heart rate';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.heartRate =
                                  int.tryParse(val ?? '0') ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Sleep Time
                const CustomTextfieldLabel(
                    label: 'Sleep Time (hours per night)'),
                const Gap(5),
                CustomTextField(
                  hintText: 'Enter sleep hours (e.g., 7)',
                  prefixIcon: Icons.bedtime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter sleep hours';
                    }
                    final hours = int.tryParse(value);
                    if (hours == null || hours < 1 || hours > 24) {
                      return 'Enter valid hours (1-24)';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.sleepTime = int.tryParse(val ?? '0') ?? 0;
                  },
                ),
              ],
            ),
          ),
          const Gap(24),

          // Health Assessment Section
          _buildSectionHeader(
              'Health Assessment', Icons.health_and_safety, Colors.orange),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange[200]!),
            ),
            child: Column(
              children: [
                // Physical Health & Mental Health Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(
                              label: 'Physical Health (1-30)'),
                          const Gap(5),
                          CustomTextField(
                            hintText: '1-30',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter score';
                              }
                              final score = int.tryParse(value);
                              if (score == null || score < 1 || score > 30) {
                                return 'Enter 1-30';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.physicalHealth =
                                  int.tryParse(val ?? '0') ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(
                              label: 'Mental Health (1-30)'),
                          const Gap(5),
                          CustomTextField(
                            hintText: '1-30',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter score';
                              }
                              final score = int.tryParse(value);
                              if (score == null || score < 1 || score > 30) {
                                return 'Enter 1-30';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.mentalHealth =
                                  int.tryParse(val ?? '0') ?? 0;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // General Health & Diabetes Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'General Health'),
                          const Gap(5),
                          DropdownButtonFormField<String>(
                            value: _genHealth,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            items: genHealthOptions.map((String health) {
                              return DropdownMenuItem<String>(
                                value: health,
                                child: Text(health),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _genHealth = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select general health';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.genHealth = val ?? '';
                            },
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomTextfieldLabel(label: 'Diabetes Status'),
                          const Gap(5),
                          DropdownButtonFormField<String>(
                            value: _diabetesStatus,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                            ),
                            items: diabetesOptions.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(status),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _diabetesStatus = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Select diabetes status';
                              }
                              return null;
                            },
                            onSaved: (val) {
                              patientModel.diabetic = val ?? 'No';
                              patientModel.diabetes = val == 'Yes';
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(16),

                // Chronic Conditions
                const CustomTextfieldLabel(label: 'Chronic Conditions'),
                const Gap(5),
                CustomTextField(
                  hintText: 'List any chronic conditions or enter "None"',
                  prefixIcon: Icons.medical_services,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter chronic conditions or "None"';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    patientModel.chronicCondition = val ?? '';
                  },
                ),
              ],
            ),
          ),
          const Gap(24),

          // Lifestyle & Habits Section
          _buildSectionHeader(
              'Lifestyle & Habits', Icons.directions_run, Colors.teal),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.teal[200]!),
            ),
            child: Column(
              children: [
                // Smoking & Alcohol Row
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Smoking'),
                        subtitle: Text(_smoking ? 'Yes' : 'No'),
                        value: _smoking,
                        onChanged: (value) {
                          setState(() {
                            _smoking = value;
                            patientModel.smoking = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Alcohol'),
                        subtitle: Text(_alcoholDrinking ? 'Yes' : 'No'),
                        value: _alcoholDrinking,
                        onChanged: (value) {
                          setState(() {
                            _alcoholDrinking = value;
                            patientModel.alcoholDrinking = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const Gap(8),

                // Physical Activity
                SwitchListTile(
                  title: const Text('Physical Activity'),
                  subtitle: Text(_physicalActivity
                      ? 'Regularly active'
                      : 'Not regularly active'),
                  value: _physicalActivity,
                  onChanged: (value) {
                    setState(() {
                      _physicalActivity = value;
                      patientModel.physicalActivity = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const Gap(24),

          // Medical Conditions Section
          _buildSectionHeader(
              'Medical Conditions', Icons.local_hospital, Colors.red),
          const Gap(16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Column(
              children: [
                // Stroke & Walking Difficulty Row
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('History of Stroke'),
                        subtitle: Text(_stroke ? 'Yes' : 'No'),
                        value: _stroke,
                        onChanged: (value) {
                          setState(() {
                            _stroke = value;
                            patientModel.stroke = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Walking Difficulty'),
                        subtitle: Text(_diffWalking ? 'Yes' : 'No'),
                        value: _diffWalking,
                        onChanged: (value) {
                          setState(() {
                            _diffWalking = value;
                            patientModel.diffWalking = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const Gap(8),

                // Asthma & Kidney Disease Row
                Row(
                  children: [
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Asthma'),
                        subtitle: Text(_asthma ? 'Yes' : 'No'),
                        value: _asthma,
                        onChanged: (value) {
                          setState(() {
                            _asthma = value;
                            patientModel.asthma = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                    Expanded(
                      child: SwitchListTile(
                        title: const Text('Kidney Disease'),
                        subtitle: Text(_kidneyDisease ? 'Yes' : 'No'),
                        value: _kidneyDisease,
                        onChanged: (value) {
                          setState(() {
                            _kidneyDisease = value;
                            patientModel.kidneyDisease = value;
                          });
                        },
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const Gap(8),

                // Skin Cancer
                SwitchListTile(
                  title: const Text('Skin Cancer'),
                  subtitle: Text(_skinCancer ? 'Yes' : 'No'),
                  value: _skinCancer,
                  onChanged: (value) {
                    setState(() {
                      _skinCancer = value;
                      patientModel.skinCancer = value;
                    });
                  },
                ),
              ],
            ),
          ),
          const Gap(24),

          // Agreement Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Transform.scale(
                  scale: 1.2,
                  child: Checkbox(
                    activeColor: AppColors.secondaryColor,
                    value: _isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                ),
                const Gap(8),
                const Expanded(
                  child: Text(
                    'I agree to all Terms, Privacy Policy and fees',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 106, 114, 132),
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Gap(24),

          // Register Button
          RegisterNavigationSection(
            isdoctor: false,
            onpressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                if (!_isChecked) {
                  showCustomSnackBar(
                    'Please agree to the terms and conditions',
                    context,
                    isError: true,
                  );
                  return;
                }
                context
                    .read<RegisterCubit>()
                    .registerPatient(patientModel: patientModel);
              }
            },
          ),
        ],
      ),
    );
  }
}
