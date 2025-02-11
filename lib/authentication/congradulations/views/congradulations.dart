import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/HeartAnaysis/ui/views/diseases_analysis.dart';
import 'package:medify/bottom_nav/bottom_nav_screens.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/heart%20diseases/ui/views/heart_diseases.dart';
import 'package:medify/onboarding/ui/widgets/welcome_message.dart';

import '../widgets/welcome_message_widget.dart';

class Congratulations extends StatefulWidget {
  Congratulations({required this.isSignUp, required this.isdoctor});
  bool isdoctor = true;
  bool isSignUp = true;
  @override
  _SuccessScreenState createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<Congratulations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;
  late Animation<double> _textFadeAnimation;

  _SuccessScreenState();
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _circleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeIn)),
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 46, 143, 255),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                  Text(
                    widget.isSignUp ? 'Sign Up' : 'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                      letterSpacing: 1,
                    ),
                  ),
                  Gap(20),
                ],
              ),
            ),
            Spacer(flex: 2),
            AnimatedBuilder(
              animation: _circleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _circleAnimation.value,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 46, 143, 255),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 8),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 80,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _textFadeAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _textFadeAnimation.value,
                  child: Column(
                    children: [
                      Text(
                        'Congratulation',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.7,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.isSignUp
                            ? 'Sign up Done Successfully!'
                            : 'Login Done Successfully!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Gap(50),
                      widget.isdoctor
                          ? GradulationsText(
                              text1: 'Welcome back Dr/Asmaa Hanfy',
                              text2: 'It\'s pleasure you are here.',
                              text3: 'Your Patients Waits for U.',
                            )
                          : GradulationsText(
                              text1:
                                  'Your Documentations have been\n Reviewed Successfully ',
                              text2: '',
                              text3: 'We hope you get Better',
                            ),
                      Gap(100),
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed(Routes.bottomNavThatHasAllScreens);
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) {
                          //   return HeartAnalysisPage();
                          // }));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          onPrimary: Color(0xFF4A90E2),
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
                              Text(
                                'Process To Your Account',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 20),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
