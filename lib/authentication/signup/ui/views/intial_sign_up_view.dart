import 'package:flutter/material.dart';
import '../../../../core/utils/app_images.dart';
import '../widgets/intial_sign_up_view_body.dart';

class IntialSignUpView extends StatelessWidget {
  const IntialSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration:  const BoxDecoration(
          image: DecorationImage(
            opacity: 0.9,
            image: AssetImage(
              Assets.assetsImagesSignUpBackground,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: const IntialSignUpViewBody(),
      ),
    );
  }
}
