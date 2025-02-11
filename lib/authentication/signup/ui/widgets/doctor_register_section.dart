import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../login/ui/widgets/custom_filled_button.dart';
import '../../../login/ui/widgets/custom_textfield.dart';
import '../../../login/ui/widgets/custom_textfield_label.dart';

class DoctorRegisterSection extends StatefulWidget {
  const DoctorRegisterSection({super.key});

  @override
  State<DoctorRegisterSection> createState() => _DoctorRegisterSectionState();
}

class _DoctorRegisterSectionState extends State<DoctorRegisterSection> {
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

        // Nationality and Clinic Name (in a row)
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfieldLabel(label: 'Nationality :'),
                  Gap(5),
                  CustomTextField(
                    hight: 30,
                  ),
                ],
              ),
            ),
            Gap(30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfieldLabel(label: 'Clinic Name :'),
                  Gap(5),
                  CustomTextField(
                    hight: 30,
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
        const CustomTextField(
          hight: 30,
        ),
        const Gap(20),

        // Year of Experience and Specialist Field (in a row)
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfieldLabel(label: 'Year Of Experience :'),
                  Gap(5),
                  CustomTextField(
                    hight: 30,
                  ),
                ],
              ),
            ),
            Gap(30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextfieldLabel(label: 'Specialist Field :'),
                  Gap(5),
                  CustomTextField(
                    hight: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
        const Gap(40),

        // Agreement Text with Checkbox
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.scale(
              scale: 0.8,
              child: Checkbox(
                value: _isChecked, // Bind the checkbox value to the state
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value ??
                        false; // Update the state when the checkbox is clicked
                  });
                },
              ),
            ),
            const Text(
              'I agree to all Term, Privacy Policy and fees',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 106, 114, 132),
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
