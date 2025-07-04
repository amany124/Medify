import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_cubit.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_state.dart';
import 'package:medify/features/authentication/reset_password/presentation/views/reset_password_otp_view.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';

class RequestResetPasswordView extends StatefulWidget {
  const RequestResetPasswordView({super.key});

  @override
  State<RequestResetPasswordView> createState() =>
      _RequestResetPasswordViewState();
}

class _RequestResetPasswordViewState extends State<RequestResetPasswordView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  String _selectedRole = 'patient';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
  
    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _requestPasswordReset() {
    if (_formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().requestResetPassword(
            email: _emailController.text.trim(),
            role: _selectedRole,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
            if (state is RequestResetPasswordFailure) {
          
            showCustomSnackBar(state.message, context, isError: true);
            } else if (state is RequestResetPasswordSuccess) {
            showCustomSnackBar('${state.message} : ${state.email}', context, isError: false);
            Navigator.push(
              context,
              MaterialPageRoute(
              builder: (context) => ResetPasswordOtpView(
                email: state.email,
                role: state.role,
              ),
              ),
            );
            }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              height: size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    const Color(0xff1877F2).withValues(alpha:0.05),
                    const Color(0xff1877F2).withValues(alpha:0.08),
                  ],
                  stops: const [0.5, 0.8, 1.0],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Gap(20),
                      const _ResetPasswordHero(),
                      const Gap(32),
                      const _GradientTitle(),
                      const Gap(16),
                      const _InfoBox(),
                      const Gap(32),
                      _AnimatedEmailField(controller: _emailController),
                      const SizedBox(height: 20),
                      const _AccountTypeLabel(),
                      const Gap(20),
                      _AccountTypeSelector(
                        selectedRole: _selectedRole,
                        onRoleChanged: (role) =>
                            setState(() => _selectedRole = role),
                      ),
                      const Gap(32),
                      _SubmitButton(
                        isLoading: state is RequestResetPasswordLoading,
                        onPressed: state is RequestResetPasswordLoading
                            ? null
                            : _requestPasswordReset,
                      ),
                      const Gap(24),
                      const _BackToLoginButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ResetPasswordHero extends StatelessWidget {
  const _ResetPasswordHero();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: 'resetPasswordIcon',
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                const Color(0xff1877F2).withValues(alpha:0.2),
                const Color(0xff1877F2).withValues(alpha:0.07),
              ],
              stops: const [0.4, 1.0],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xff1877F2).withValues(alpha:0.08),
                blurRadius: 30,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.8, end: 1.0),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: const Color(0xff1877F2).withValues(alpha:0.15),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff1877F2).withValues(alpha:0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_reset,
                    size: 90,
                    color: Color(0xff1877F2),
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientTitle extends StatelessWidget {
  const _GradientTitle();

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          colors: [Color(0xff1877F2), Color(0xff3498db)],
        ).createShader(bounds);
      },
      child: const Text(
        'Forgot your password?',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _InfoBox extends StatelessWidget {
  const _InfoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xff1877F2).withValues(alpha:0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.04),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xff1877F2),
            size: 22,
          ),
          Gap(14),
          Expanded(
            child: Text(
              'Enter your email address. We\'ll send you an OTP to reset your password.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedEmailField extends StatelessWidget {
  final TextEditingController controller;
  const _AnimatedEmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16),
        cursorColor: const Color(0xff1877F2),
        decoration: InputDecoration(
          labelText: 'Email Address',
          labelStyle: TextStyle(
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
          hintText: 'Enter your email address',
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xff1877F2).withValues(alpha:0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.email_outlined,
              color: Color(0xff1877F2),
              size: 20,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey[200]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(
              color: Color(0xff1877F2),
              width: 1.5,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 22),
          errorStyle: const TextStyle(color: Colors.redAccent),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelStyle: const TextStyle(
            color: Color(0xff1877F2),
            fontWeight: FontWeight.w500,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          if (!value.contains('@') || !value.contains('.')) {
            return 'Please enter a valid email';
          }
          return null;
        },
      ),
    );
  }
}

class _AccountTypeLabel extends StatelessWidget {
  const _AccountTypeLabel();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Account Type',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(10),
        Container(
          height: 2,
          width: 30,
          decoration: BoxDecoration(
            color: const Color(0xff1877F2).withValues(alpha:0.3),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class _AccountTypeSelector extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  const _AccountTypeSelector({
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AccountTypeOption(
            label: 'Patient',
            icon: Icons.person,
            value: 'patient',
            selected: selectedRole == 'patient',
            onTap: () => onRoleChanged('patient'),
          ),
        ),
        const Gap(16),
        Expanded(
          child: _AccountTypeOption(
            label: 'Doctor',
            icon: Icons.medical_services_outlined,
            value: 'doctor',
            selected: selectedRole == 'doctor',
            onTap: () => onRoleChanged('doctor'),
          ),
        ),
      ],
    );
  }
}

class _AccountTypeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _AccountTypeOption({
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 66,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff1877F2).withValues(alpha:0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xff1877F2)
                : Colors.grey[300]!,
            width: selected ? 2 : 1,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: const Color(0xff1877F2).withValues(alpha:0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xff1877F2)
                    : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? const Color(0xff1877F2)
                      : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            const Gap(10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.normal,
                  color: selected
                      ? const Color(0xff1877F2)
                      : Colors.black87,
                ),
              ),
            ),
            if (selected)
              Icon(
                icon,
                color: const Color(0xff1877F2),
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const _SubmitButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: isLoading
              ? [
                  const Color(0xff1877F2).withValues(alpha:0.7),
                  const Color(0xff1877F2).withValues(alpha:0.7),
                ]
              : [
                  const Color(0xff1877F2),
                  const Color(0xff3498db),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff1877F2).withValues(alpha:0.4),
            blurRadius: isLoading ? 0 : 15,
            offset: const Offset(0, 6),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onPressed,
          splashColor: Colors.white.withValues(alpha:0.2),
          highlightColor: Colors.transparent,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_reset_rounded,
                          size: 22,
                          color: Colors.white,
                        ),
                        Gap(10),
                        Text(
                          'Send Reset Code',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BackToLoginButton extends StatelessWidget {
  const _BackToLoginButton();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.grey[50],
        ),
        child: TextButton.icon(
          onPressed: () => context.pushNamed(Routes.loginScreen),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Color(0xff1877F2),
          ),
          label: const Text(
            'Back to Login',
            style: TextStyle(
              color: Color(0xff1877F2),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
