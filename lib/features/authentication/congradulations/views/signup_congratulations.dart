import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';

import '../../../../core/di/di.dart';
import '../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../core/routing/routes.dart';
import '../../../heart diseases/data/models/heart_diseases_request_model.dart';
import '../../../heart diseases/presentation/cubit/predict_disease_cubit.dart';
import '../../../heart diseases/presentation/cubit/predict_disease_state.dart';
import '../../../heart diseases/ui/views/bad_result.dart';
import '../../../heart diseases/ui/views/good_result.dart';
import '../widgets/welcome_message_widget.dart';

class SignUpCongratulationsView extends StatefulWidget {
  const SignUpCongratulationsView({
    super.key,
    this.isdoctor = true,
    this.userName,
  });
  final bool isdoctor;
  final String? userName;

  @override
  SignUpCongratulationsState createState() => SignUpCongratulationsState();
}

class SignUpCongratulationsState extends State<SignUpCongratulationsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _circleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PredictDiseaseCubit>(),
      lazy: false,
      child: Scaffold(
        backgroundColor:
            const Color.fromARGB(255, 46, 143, 255), // Blue theme for sign up
        body: BlocConsumer<PredictDiseaseCubit, PredictDiseaseState>(
          listener: (context, state) {
            if (state is PredictDiseaseFailure) {
              showCustomSnackBar(
                state.failure.message,
                context,
                isError: true,
              );
            } else if (state is PredictDiseaseSuccess) {
              Future.microtask(() {
                if (!mounted) return;

                if (state.response.diagnosis.contains('⚠️ يوجد خطر للإصابة')) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BadResultPage(
                        heartDiseasesResponse: state.response,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoodResultPage(
                        heartDiseasesResponse: state.response,
                      ),
                    ),
                  );
                }
              });
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 28,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            context.pop();
                          },
                        ),
                        const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                            letterSpacing: 1,
                          ),
                        ),
                        const Gap(20),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedBuilder(
                    animation: _circleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _circleAnimation.value,
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 46, 143, 255),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 8),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_add,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  AnimatedBuilder(
                    animation: _textFadeAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _textFadeAnimation.value,
                        child: Column(
                          children: [
                            const Text(
                              'Congratulations!',
                              style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.7,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Account Created Successfully!',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const Gap(50),
                            widget.isdoctor
                                ? GradulationsText(
                                    text1: 'Welcome Dr. ${widget.userName},',
                                    text2:
                                        'Thank you for joining our platform.',
                                    text3: 'Start helping patients today!',
                                  )
                                : GradulationsText(
                                    text1: 'Welcome ${widget.userName},',
                                    text2: 'Your health journey begins now.',
                                    text3:
                                        'Let\'s check your initial health status.',
                                  ),
                            const Gap(100),
                            ElevatedButton(
                              onPressed: state is PredictDiseaseLoading
                                  ? null
                                  : () {
                                      if (widget.isdoctor) {
                                        context.pushReplacementNamed(
                                            Routes.bottomNavThatHasAllScreens);
                                      } else {
                                        log('New patient - getting initial diagnosis');
                                        final cubit =
                                            context.read<PredictDiseaseCubit>();

                                        // Create a default request for new patients
                                        cubit.setRequest(HeartDiseasesRequest(
                                          bmi: 25.0,
                                          smoking: 'No',
                                          alcoholDrinking: 'No',
                                          stroke: 'No',
                                          physicalHealth: 0,
                                          mentalHealth: 0,
                                          diffWalking: 'No',
                                          sex: 'Female',
                                          ageCategory: '25-29',
                                          race: 'White',
                                          diabetic: 'No',
                                          physicalActivity: 'Yes',
                                          genHealth: 'Very good',
                                          sleepTime: 7,
                                          asthma: 'No',
                                          kidneyDisease: 'No',
                                          skinCancer: 'No',
                                        ));

                                        cubit.predictHeartDisease();
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: const Color(0xFF4A90E2),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24.0, vertical: 12.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (state is PredictDiseaseLoading)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Color(0xFF4A90E2),
                                          ),
                                        ),
                                      )
                                    else
                                      !widget.isdoctor
                                          ? const Text(
                                              'Get My Initial Diagnosis',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              'Start My Journey',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                    if (state is! PredictDiseaseLoading) ...[
                                      const SizedBox(width: 20),
                                      const Icon(Icons.arrow_forward),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
