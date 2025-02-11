
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../login/ui/widgets/custom_filled_button.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';

class PatientRegisterSection extends StatefulWidget {
  const PatientRegisterSection({super.key});

  @override
  State<PatientRegisterSection> createState() => _PatientRegisterSectionState();
}

class _PatientRegisterSectionState extends State<PatientRegisterSection> {
  bool _isChecked = false; // State to manage the checkbox

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        const CustomTextfieldLabel(label: 'Full Name'),
        const Gap(5),
        const CustomTextField(
          hintText: 'Enter your full name',
          prefixIcon: Icons.person_outline_rounded,
        ),
        const Gap(10),

        // Email
        const CustomTextfieldLabel(label: 'Email'),
        const Gap(5),
        const CustomTextField(
          hintText: 'Enter your email',
          prefixIcon: Icons.email_outlined,
        ),
        const Gap(10),

        // Username
        const CustomTextfieldLabel(label: 'Username'),
        const Gap(5),
        const CustomTextField(
          hintText: 'Enter your username',
          prefixIcon: Icons.person_outline_rounded,
        ),
        const Gap(10),

        // Password
        const CustomTextfieldLabel(label: 'Password'),
        const Gap(5),
        const CustomTextField(
          hintText: 'Enter your password',
          prefixIcon: Icons.lock_outline_rounded,
        ),
        const Gap(20),

        // Blood Type, Height, Weight (in a row)
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextfieldLabel(label: 'Blood Type :',
                  fontsize: 13.9,
                  ),
                  const Gap(5),
                  const CustomTextField(
                      hight: 30,
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
                  const CustomTextField(
                    hight: 30,
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
                  const CustomTextField(
                    hight: 30,
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
                  const CustomTextField(
                     hight: 30,
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
                  const CustomTextField(
                      hight: 30,
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
                  const CustomTextField(
                     hight: 30,
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
                  const CustomTextField(
                     hight: 30,
                  ),
                ],
              ),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextfieldLabel(label: 'BMI :'),
                  const Gap(5),
                  const CustomTextField(
                    hight: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(50),

        // Agreement Text with Checkbox
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.7, // Adjust the size of the checkbox
              child: Checkbox(
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
                fontSize: 14,
                color: Color(0xff667085),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Gap(20),

   
        
      ],
    );
  }
}