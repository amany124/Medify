import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/app_router.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';
//import 'package:graduation_project/core/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../authentication/login/ui/views/login_view.dart';
//import '../../../authentication/signup/ui/views/intial_sign_up_view.dart';
import '../../../authentication/signup/ui/views/intial_sign_up_view.dart';
import '../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/widgets/custom_button.dart';

class StartView extends StatelessWidget {
  const StartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/auth_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.assetsImagesAppLogo,
                height: 120,
              ),
              const Gap(7),
              const Text(
                'Medify',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff223A6A),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
              const Gap(15),
              const Text(
                'Let\'s get started!',
                style: TextStyle(
                  fontSize: 32,
                  color: Color(0xff221F1F),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                ),
              ),
              const Gap(0.5),
              Text(
                'Login to stay healthy and fit',
                style: AppStyles.regular16,
              ),
              const Gap(35),
              CustomButton(
                text: 'Login',
                backgroundColor: AppColors.secondaryColor,
                textColor: Colors.white,
                buttonWidth: 200,
                onPressed: () {
                  context.pushNamed(Routes.loginScreen);
                },
              ),
              const Gap(15),
              CustomButton(
                text: "Sign up",
                backgroundColor: Colors.white,
                textColor: AppColors.secondaryColor,
                buttonWidth: 200,
                onPressed: () {
                  context.pushNamed(Routes.IntialSignUpView);
                },
                borderColor: AppColors.secondaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
