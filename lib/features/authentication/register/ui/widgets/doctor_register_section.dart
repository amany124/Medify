import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/theme/app_colors.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';
import '../../data/models/doctor_model.dart';
import '../cubit/register_cubit/register_cubit.dart';
import 'register_navigation_section.dart';

class DoctorRegisterSection extends StatefulWidget {
  const DoctorRegisterSection({super.key});

  @override
  State<DoctorRegisterSection> createState() => _DoctorRegisterSectionState();
}

class _DoctorRegisterSectionState extends State<DoctorRegisterSection> {
  bool _isChecked = false; // State to manage the checkbox
  DoctorModel doctorModel = DoctorModel(
    name: '',
    email: '',
    username: '',
    password: '',
    gender: 'male', // Default gender
    role: 'doctor',
    nationality: '',
    clinicName: '',
    clinicAddress: '',
    specialization: '',
    experienceYears: 0,
  ); // Initialize doctorModel
  var formKey = GlobalKey<FormState>();

  // List of gender options
  final List<String> genderOptions = ['male', 'female'];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
              doctorModel.name = val ?? '';
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
              doctorModel.email = val ?? '';
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
              doctorModel.username = val ?? '';
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
              doctorModel.password = val ?? '';
            },
          ),
          const Gap(20),

          // Gender Dropdown
          const CustomTextfieldLabel(label: 'Gender'),
          const Gap(5),
          DropdownButtonFormField<String>(
            value: doctorModel.gender, // Default value
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            items: genderOptions.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                doctorModel.gender = value ?? 'male';
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your gender';
              }
              return null;
            },
          ),
          const Gap(20),

          // Nationality and Clinic Name (in a row)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Nationality :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your nationality';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        doctorModel.nationality = val ?? '';
                      },
                    ),
                  ],
                ),
              ),
              const Gap(30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Clinic Name :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your clinic name';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        doctorModel.clinicName = val ?? '';
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),

          // Clinic Address
          const CustomTextfieldLabel(label: 'Clinic Address :'),
          const Gap(5),
          CustomTextField(
            height: 30,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your clinic address';
              }
              return null;
            },
            onSaved: (val) {
              doctorModel.clinicAddress = val ?? '';
            },
          ),
          const Gap(20),

          // Year of Experience and Specialist Field (in a row)
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Year Of Experience :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter years of experience';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        doctorModel.experienceYears = int.parse(val ?? '0');
                      },
                    ),
                  ],
                ),
              ),
              const Gap(30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextfieldLabel(label: 'Specialist Field :'),
                    const Gap(5),
                    CustomTextField(
                      height: 30,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your specialization';
                        }
                        return null;
                      },
                      onSaved: (val) {
                        doctorModel.specialization = val ?? '';
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
            isdoctor: true,
            onpressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
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
                    .registerDoctor(doctorModel: doctorModel);
              }
            },
          ),
        ],
      ),
    );
  }
}
