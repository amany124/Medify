import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart' show Dio;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_cubit.dart';
import 'package:medify/features/authentication/reset_password/presentation/cubits/reset_password_state.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/helpers/show_custom_snack_bar.dart';
import '../../data/repos/reset_password_repo.dart';

class ResetPasswordOtpView extends StatefulWidget {
  final String email;
  final String role;

  const ResetPasswordOtpView({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<ResetPasswordOtpView> createState() => _ResetPasswordOtpViewState();
}

class _ResetPasswordOtpViewState extends State<ResetPasswordOtpView> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _currentOTP = "";
  bool _hasError = false;
  final _focusNode = FocusNode();
  late final ResetPasswordCubit _resetPasswordCubit;

  @override
  void initState() {
    super.initState();
    _resetPasswordCubit = ResetPasswordCubit(
      resetPasswordRepo: ResetPasswordRepoImpl(
        apiServices: ApiServices(Dio()),
      ),
    );
    Future.delayed(const Duration(milliseconds: 150), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _focusNode.dispose();
    _resetPasswordCubit.close();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _resetPasswordCubit.resetPassword(
        email: widget.email,
        role: widget.role,
        otp: _currentOTP,
        newPassword: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _resetPasswordCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Reset Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(0x0fffffff),
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is VerifyOtpFailure) {
              showCustomSnackBar(state.message, context, isError: true);
              setState(() {
                _hasError = true;
              });
            } else if (state is VerifyOtpSuccess) {
              showCustomSnackBar(state.message, context, isError: false);
              // Navigate back to login screen after successful password reset
              Future.delayed(const Duration(seconds: 2), () {
                context.pushReplacementNamed(Routes.loginScreen);
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: FadeInDown(
                          duration: const Duration(milliseconds: 600),
                          child: Image.asset(
                            'assets/images/otp_verification.jpg',
                            height: 250,
                            width: 250,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.password,
                              size: 100,
                              color: Color(0xff1877F2),
                            ),
                          ),
                        ),
                      ),
                      // const Gap(13),
                      FadeInLeft(
                        duration: const Duration(milliseconds: 500),
                        child: const Text(
                          'OTP Verification',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Gap(8),
                      FadeInLeft(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          'We have sent an OTP to ${widget.email}. Enter the code below to reset your password.',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Gap(32),

                      // Modern Pin Code Field
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 6,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(12),
                            fieldHeight: 56,
                            fieldWidth: 46,
                            activeFillColor: _hasError
                                ? Colors.red.shade50
                                : Colors.blue.shade50,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: Colors.blue.shade100,
                            activeColor: _hasError
                                ? Colors.red
                                : const Color(0xff1877F2),
                            inactiveColor: Colors.grey,
                            selectedColor: const Color(0xff1877F2),
                          ),
                          cursorColor: const Color(0xff1877F2),
                          animationDuration: const Duration(milliseconds: 300),
                          enableActiveFill: true,
                          keyboardType: TextInputType.number,
                          controller: _otpController,
                          focusNode: _focusNode,
                          onChanged: (value) {
                            setState(() {
                              _currentOTP = value;
                              _hasError = false;
                            });
                          },
                          beforeTextPaste: (text) {
                            // You can check if pasted text is a valid OTP
                            return text != null &&
                                text.length == 6 &&
                                int.tryParse(text) != null;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter the OTP';
                            }
                            if (value.length != 6) {
                              return 'OTP must be 6 digits';
                            }
                            return null;
                          },
                        ),
                      ),
                      const Gap(20),

                      // Enhanced Password Field
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              labelText: 'New Password',
                              hintText: 'Enter your new password',
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Color(0xff1877F2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xff1877F2), width: 1.5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your new password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const Gap(20),

                      // Enhanced Confirm Password Field
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: _obscureConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: 'Confirm your new password',
                              prefixIcon: const Icon(
                                Icons.lock_outlined,
                                color: Color(0xff1877F2),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.grey,
                                ),
                                onPressed: () => setState(() =>
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Colors.grey, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                    color: Color(0xff1877F2), width: 1.5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      const Gap(32),

                      // Enhanced Reset Button
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 600),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1877F2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 1,
                            ),
                            onPressed: state is VerifyOtpLoading
                                ? null
                                : _resetPassword,
                            child: state is VerifyOtpLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Reset Password',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Icon(
                                        Icons.lock_reset,
                                        size: 20,
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const Gap(20),

                      // Try again button
                      Center(
                        child: FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 600),
                          child: TextButton.icon(
                            onPressed: () {
                              // Navigate back to the request reset view to request a new OTP
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 18,
                              color: Color(0xff1877F2),
                            ),
                            label: const Text(
                              "Didn't receive OTP? Try again",
                              style: TextStyle(
                                color: Color(0xff1877F2),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
