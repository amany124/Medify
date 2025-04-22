import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/login/data/models/login_user_model.dart';
import 'package:medify/features/authentication/login/ui/cubits/cubit/login_cubit.dart';
import 'package:medify/features/authentication/login/ui/widgets/custom_filled_button.dart';
import 'package:medify/features/authentication/login/ui/widgets/custom_textfield.dart';
import 'package:medify/features/authentication/login/ui/widgets/custom_textfield_label.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../../core/theme/app_colors.dart';

class UserLoginSection extends StatefulWidget {
  const UserLoginSection({super.key});

  @override
  State<UserLoginSection> createState() => _UserLoginSectionState();
}

class _UserLoginSectionState extends State<UserLoginSection> {
  bool _isChecked = false;
  final List<String> roleOptions = ['Doctor', 'Patient'];
  String? _selectedRole;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Email
          const CustomTextfieldLabel(label: 'Email'),
          const Gap(10),
          CustomTextField(
            hintText: 'Enter your email',
            prefixIcon: Icons.email_outlined,
            onSaved: (value) {
              _email = value;
            },
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
          ),
          const Gap(10),

          // Password
          const CustomTextfieldLabel(label: 'Password'),
          const Gap(10),
          CustomTextField(
            hintText: 'Enter your password',
            onSaved: (value) {
              _password = value;
            },
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
          ),
          const Gap(22),

          // Role Dropdown
          DropdownButtonFormField<String>(
            value: _selectedRole,
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
            hint: const Text('Select your role'),
            items: roleOptions.map((String role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _selectedRole = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select your role';
              }
              return null;
            },
          ),
          const Gap(10),

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
          const Gap(23),

          // Login Button
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return CustomFilledButton(
                isLoading: state is LoginLoading,
                text: 'Login',
                onPressed: () {
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
                    context.read<LoginCubit>().login(
                            loginUserModel: LoginUserModel(
                          email: _email!,
                          password: _password!,
                          role: _selectedRole!,
                        ));
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
