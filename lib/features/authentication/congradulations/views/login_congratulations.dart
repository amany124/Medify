import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';

import '../../../../core/routing/routes.dart';
import '../widgets/welcome_message_widget.dart';

class LoginCongratulationsView extends StatefulWidget {
  const LoginCongratulationsView({
    super.key,
    this.isdoctor = true,
    this.userName,
  });
  final bool isdoctor;
  final String? userName;

  @override
  _LoginCongratulationsState createState() => _LoginCongratulationsState();
}

class _LoginCongratulationsState extends State<LoginCongratulationsView>
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
    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 46, 143, 255), // Blue theme for sign up
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
                    'Login',
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
                      color: const Color.fromARGB(
                          255, 46, 143, 255), // Blue theme for sign up,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.login,
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
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.7,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Login Done Successfully!',
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
                              text1: 'Welcome back Dr. ${widget.userName},',
                              text2: 'Ready to help your patients today.',
                              text3: 'Your expertise makes a difference.',
                            )
                          : GradulationsText(
                              text1: 'Welcome back ${widget.userName},',
                              text2: 'We\'re glad to see you again.',
                              text3: 'Your health journey continues.',
                            ),
                      const Gap(100),
                      ElevatedButton(
                        onPressed: () {
                          context.pushReplacementNamed(
                              Routes.bottomNavThatHasAllScreens);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: const Color.fromARGB(
                              255, 46, 143, 255), // Blue theme for sign up

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
                              const Text(
                                'proccess to Your account',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 20),
                              const Icon(Icons.arrow_forward),
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
      ),
    );
  }
}
