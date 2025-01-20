import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass/glass.dart';

import 'app_logo_with_title.dart';
import 'sign_up_vector_line.dart';
import 'signup_buttons.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/app_logo_with_title.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/sign_up_vector_line.dart';
//import 'package:graduation_project/features/authentication/signup/ui/widgets/signup_buttons.dart';

class BlurContainer extends StatelessWidget {
  const BlurContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 300,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppLogoWithTitle(),
          Gap(15),
          SignupButtons(),
          Gap(20),
          SignUpVectorLine(),
        ],
      ),
    ).asGlass(frosted: true);
  }
}
