import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/register/ui/widgets/register_navigation_section.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';
import '../../data/models/patient_model.dart';
import '../cubit/register_cubit/register_cubit.dart'; // Import the PatientModel

class PatientRegisterSection extends StatefulWidget {
  const PatientRegisterSection({super.key});

  @override
  State<PatientRegisterSection> createState() => _PatientRegisterSectionState();
}

class _PatientRegisterSectionState extends State<PatientRegisterSection> {
  bool _isChecked = false; // State to manage the checkbox

  // Initialize PatientModel
  PatientModel patientModel = PatientModel(
<<<<<<< HEAD
    id: '',
=======
<<<<<<< HEAD
    id: '',
=======
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
    name: '',
    email: '',
    username: '',
    password: '',
    role: 'patient',
    gender: 'male', // Default gender
    dateOfBirth: '',
    bloodType: '',
    height: 0,
    weight: 0,
    chronicCondition: '',
    diabetes: false,
    heartRate: 0,
  );

  // Dropdown values
  String? _bloodType;
  String? _diabetesStatus;

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

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controller for Date of Birth field
  final TextEditingController _dateOfBirthController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const Gap(10),

          // Email
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
          const Gap(10),

          // Username
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
          const Gap(10),

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
          const Gap(20),

          // Blood Type, Height, Weight (in a row)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(
                      label: 'Blood Type :',
                      fontsize: 13.9,
                    ),
                    const Gap(5),
                    DropdownButtonFormField<String>(
                      value: _bloodType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
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
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Height :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.height = int.tryParse(val ?? '0') ?? 0;
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
                    const CustomTextfieldLabel(label: 'Weight :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.weight = int.tryParse(val ?? '0') ?? 0;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),

          // Date of Birth and Chronic Conditions (in a row)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Date Of Birth :'),
                    const Gap(5),
                    TextFormField(
                      controller: _dateOfBirthController,
                      decoration: InputDecoration(
                        hintText: 'Select your date of birth',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () => _selectDate(context),
                        ),
                      ),
                      readOnly: true, // Prevent manual editing
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
                  ],
                ),
              ),
              const Gap(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Chronic Conditions :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter chronic conditions';
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
            ],
          ),
          const Gap(20),

          // Diabetes, Heart Rate, BMI (in a row)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Diabetes :'),
                    const Gap(5),
                    DropdownButtonFormField<String>(
                      value: _diabetesStatus,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
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
                          return 'Please select diabetes status';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.diabetes = val == 'Yes';
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
                    const CustomTextfieldLabel(label: 'Heart Rate :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your heart rate';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        patientModel.heartRate = int.tryParse(val ?? '0') ?? 0;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),

          // Agreement Text with Checkbox
          Row(
            children: [
              Transform.scale(
                scale: 0.8,
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
              const Text(
                'I agree to all Term, Privacy Policy and fees',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 106, 114, 132),
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Gap(10),
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
              }),
        ],
      ),
    );
  }
}
