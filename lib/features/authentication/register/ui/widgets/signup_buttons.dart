import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';

import '../../../../../core/utils/app_images.dart';
import 'custom_sign_up_button.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/custom_sign_up_button.dart';
//import 'package:graduation_project/core/utils/app_images.dart';

class SignupButtons extends StatelessWidget {
  const SignupButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSignUpButton(
          icon: Assets.assetsImagesDoctorIcon,
          type: 'Doctor',
          onTap: () {
            context.pushNamed(Routes.signUpAsDoctor);
          },
        ),
        const Gap(10),
        CustomSignUpButton(
          icon: Assets.assetsImagesPatientIcon,
          type: 'Patient',
          onTap: () {
            context.pushNamed(Routes.signUpAsPatient);
          },
        ),
      ],
    );
  }
}
