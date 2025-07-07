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

class ModernPatientRegisterSection extends StatefulWidget {
  const ModernPatientRegisterSection({super.key});

  @override
  State<ModernPatientRegisterSection> createState() =>
      _ModernPatientRegisterSectionState();
}

class _ModernPatientRegisterSectionState
    extends State<ModernPatientRegisterSection> {
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

  // Controllers
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _bmiController = TextEditingController();
  final TextEditingController _heartRateController = TextEditingController();
  final TextEditingController _chronicConditionController =
      TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

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
  final List<String> diabetesOptions = ['Yes', 'No', 'Pre-diabetic'];
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
    _diabetes = false;

    // Add listeners for BMI calculation
    _heightController.addListener(_calculateBMI);
    _weightController.addListener(_calculateBMI);
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    _bmiController.dispose();
    _heartRateController.dispose();
    _chronicConditionController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  // Function to calculate BMI
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
    return 0.75 + ((bmi - 30.0) / 10.0) * 0.25; // Cap at 1.0
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const Gap(12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(Widget child, Color borderColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildBMIProgressIndicator() {
    final bmi = double.tryParse(_bmiController.text) ?? 0.0;
    if (bmi <= 0) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'BMI Category:',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getBMIColor(bmi).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _getBMICategory(bmi),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: _getBMIColor(bmi),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Tooltip(
          message: 'BMI: ${bmi.toStringAsFixed(1)} - ${_getBMICategory(bmi)}',
          child: LinearProgressIndicator(
            value: _getBMIProgress(bmi).clamp(0.0, 1.0),
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(_getBMIColor(bmi)),
            minHeight: 8,
          ),
        ),
        const Gap(4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Underweight',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            Text(
              'Normal',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            Text(
              'Overweight',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
            Text(
              'Obese',
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBooleanTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: value ? Colors.green[50] : Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? Colors.green[300]! : Colors.grey[300]!,
        ),
      ),
      child: SwitchListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: Colors.green,
        secondary: Icon(
          icon,
          color: value ? Colors.green : Colors.grey,
        ),
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
          _buildSectionCard(
            Column(
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
                  prefixIcon: Icons.lock_outline,
                  isObscureText: true,
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
            AppColors.secondaryColor,
          ),
          const Gap(24),

          // Personal Details Section
          _buildSectionHeader('Personal Details', Icons.badge, Colors.blue),
          const Gap(16),
          _buildSectionCard(
            Column(
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
                              hintStyle: TextStyle(
                                fontSize: 12,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
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
                                borderRadius: BorderRadius.circular(12),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Blood Type'),
                    const Gap(5),
                    DropdownButtonFormField<String>(
                      value: _bloodType,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 14,
                        ),
                        hintText: 'Select blood type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      items: bloodTypes.map((String bloodType) {
                        return DropdownMenuItem<String>(
                          value: bloodType,
                          child: Text(bloodType),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _bloodType = value;
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
                    ),
                  ],
                ),
                const Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Age Category'),
                    const Gap(5),
                    DropdownButtonFormField<String>(
                      value: _ageCategory,
                      decoration: InputDecoration(
                        hintText: 'Select age category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      items: ageCategoryOptions.map((String age) {
                        return DropdownMenuItem<String>(
                          value: age,
                          child: Text(age),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _ageCategory = value;
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
                    ),
                  ],
                ),
                const Gap(16),

                // Race
                Align(
                  alignment: Alignment.centerLeft,
                  child: const CustomTextfieldLabel(label: 'Race')),
                const Gap(5),
                DropdownButtonFormField<String>(
                  value: _race,
                  decoration: InputDecoration(
                    hintText: 'Select race',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
            Colors.blue,
          ),
          const Gap(24),

          // Health Metrics Section
          _buildSectionHeader(
              'Health Metrics', Icons.monitor_heart, Colors.green),
          const Gap(16),
          _buildSectionCard(
            Column(
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
                          TextFormField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              hintText: 'Enter height in cm',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.height),
                            ),
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
                          TextFormField(
                            controller: _weightController,
                            decoration: InputDecoration(
                              hintText: 'Enter weight in kg',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              prefixIcon: const Icon(Icons.monitor_weight),
                            ),
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

                // BMI Field (Auto-calculated)
                const CustomTextfieldLabel(label: 'BMI (Body Mass Index)'),
                const Gap(5),
                TextFormField(
                  controller: _bmiController,
                  decoration: InputDecoration(
                    hintText: 'Auto-calculated from height and weight',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.calculate),
                    fillColor: Colors.grey[100],
                    filled: true,
                  ),
                  readOnly: true,
                  onSaved: (val) {
                    patientModel.bmi = double.tryParse(val ?? '0') ?? 0.0;
                  },
                ),
                const Gap(16),

                // BMI Progress Indicator
                _buildBMIProgressIndicator(),
                const Gap(16),

                // Heart Rate
                const CustomTextfieldLabel(label: 'Heart Rate (bpm)'),
                const Gap(5),
                TextFormField(
                  controller: _heartRateController,
                  decoration: InputDecoration(
                    hintText: 'Enter heart rate in bpm',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.favorite),
                  ),
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

                // Physical Health & Mental Health Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const CustomTextfieldLabel(
                    label: 'Physical Health (1-30)'),
                  const Gap(5),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Days of poor physical health',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.fitness_center),
                    ),
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
                    patientModel.physicalHealth =
                      int.tryParse(val ?? '0') ?? 0;
                    },
                  ),
                  const Gap(16),
                  const CustomTextfieldLabel(
                    label: 'Mental Health (1-30)'),
                  const Gap(5),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Days of poor mental health',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.psychology),
                    ),
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
                    patientModel.mentalHealth =
                      int.tryParse(val ?? '0') ?? 0;
                    },
                  ),
                  ],
                ),
                const Gap(16),

                // General Health & Sleep Time Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  const CustomTextfieldLabel(label: 'General Health'),
                  const Gap(5),
                  DropdownButtonFormField<String>(
                    value: _genHealth,
                    decoration: InputDecoration(
                    hintText: 'Select general health',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
                      return 'Please select general health';
                    }
                    return null;
                    },
                    onSaved: (val) {
                    patientModel.genHealth = val ?? '';
                    },
                  ),
                  const Gap(16),
                  const CustomTextfieldLabel(label: 'Sleep Time (hours)'),
                  const Gap(5),
                  TextFormField(
                    decoration: InputDecoration(
                    hintText: 'Hours of sleep per night',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.bedtime),
                    ),
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
                    patientModel.sleepTime =
                      int.tryParse(val ?? '0') ?? 0;
                    },
                  ),
                  ],
                ),
                const Gap(16),

                // Chronic Condition
                const CustomTextfieldLabel(label: 'Chronic Condition'),
                const Gap(5),
                TextFormField(
                  controller: _chronicConditionController,
                  decoration: InputDecoration(
                    hintText: 'Enter any chronic conditions',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.medical_services),
                  ),
                  maxLines: 2,
                  onSaved: (val) {
                    patientModel.chronicCondition = val ?? '';
                  },
                ),
              ],
            ),
            Colors.green,
          ),
          const Gap(24),

          // Medical History Section
          _buildSectionHeader(
              'Medical History', Icons.local_hospital, Colors.orange),
          const Gap(16),
          _buildSectionCard(
            Column(
              children: [
                // Diabetes Status
                const CustomTextfieldLabel(label: 'Diabetes Status'),
                const Gap(5),
                DropdownButtonFormField<String>(
                  value: _diabetesStatus,
                  decoration: InputDecoration(
                    hintText: 'Select diabetes status',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                  items: diabetesOptions.map((String diabetes) {
                    return DropdownMenuItem<String>(
                      value: diabetes,
                      child: Text(diabetes),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      _diabetesStatus = value;
                      _diabetes = value == 'Yes';
                    });
                  },
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
                const Text(
                  'Medical Conditions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
                const Gap(12),

                _buildBooleanTile(
                  title: 'Smoking',
                  subtitle: 'Do you smoke or have you smoked?',
                  value: _smoking,
                  onChanged: (value) {
                    setState(() {
                      _smoking = value;
                      patientModel.smoking = value;
                    });
                  },
                  icon: Icons.smoking_rooms,
                ),

                _buildBooleanTile(
                  title: 'Alcohol Drinking',
                  subtitle: 'Do you drink alcohol regularly?',
                  value: _alcoholDrinking,
                  onChanged: (value) {
                    setState(() {
                      _alcoholDrinking = value;
                      patientModel.alcoholDrinking = value;
                    });
                  },
                  icon: Icons.local_bar,
                ),

                _buildBooleanTile(
                  title: 'Stroke',
                  subtitle: 'Have you ever had a stroke?',
                  value: _stroke,
                  onChanged: (value) {
                    setState(() {
                      _stroke = value;
                      patientModel.stroke = value;
                    });
                  },
                  icon: Icons.healing,
                ),

                _buildBooleanTile(
                  title: 'Difficulty Walking',
                  subtitle:
                      'Do you have difficulty walking or climbing stairs?',
                  value: _diffWalking,
                  onChanged: (value) {
                    setState(() {
                      _diffWalking = value;
                      patientModel.diffWalking = value;
                    });
                  },
                  icon: Icons.accessibility,
                ),

                _buildBooleanTile(
                  title: 'Physical Activity',
                  subtitle: 'Do you engage in regular physical activity?',
                  value: _physicalActivity,
                  onChanged: (value) {
                    setState(() {
                      _physicalActivity = value;
                      patientModel.physicalActivity = value;
                    });
                  },
                  icon: Icons.fitness_center,
                ),

                _buildBooleanTile(
                  title: 'Asthma',
                  subtitle: 'Do you have asthma?',
                  value: _asthma,
                  onChanged: (value) {
                    setState(() {
                      _asthma = value;
                      patientModel.asthma = value;
                    });
                  },
                  icon: Icons.air,
                ),

                _buildBooleanTile(
                  title: 'Kidney Disease',
                  subtitle: 'Do you have kidney disease?',
                  value: _kidneyDisease,
                  onChanged: (value) {
                    setState(() {
                      _kidneyDisease = value;
                      patientModel.kidneyDisease = value;
                    });
                  },
                  icon: Icons.medical_services,
                ),

                _buildBooleanTile(
                  title: 'Skin Cancer',
                  subtitle: 'Do you have skin cancer?',
                  value: _skinCancer,
                  onChanged: (value) {
                    setState(() {
                      _skinCancer = value;
                      patientModel.skinCancer = value;
                    });
                  },
                  icon: Icons.spa,
                ),
              ],
            ),
            Colors.orange,
          ),
          const Gap(24),

          // Terms and Conditions
          Container(
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
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: AppColors.secondaryColor,
            ),
          ),
          const Gap(24),

          // Register Button
          RegisterNavigationSection(
            isdoctor: false,
            onpressed: () {
              if (_formKey.currentState!.validate()) {
                if (_isChecked) {
                  _formKey.currentState!.save();
                  context
                      .read<RegisterCubit>()
                      .registerPatient(patientModel: patientModel);
                } else {
                  showCustomSnackBar(
                    'Please agree to the Terms and Conditions',
                    context,
                    isError: true,
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
