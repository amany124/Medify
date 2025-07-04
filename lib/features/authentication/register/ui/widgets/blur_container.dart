import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:glass/glass.dart';

import 'app_logo_with_title.dart';
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
      height: 340,
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.blueAccent,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          const Gap(5),
          const AppLogoWithTitle(),
          const Gap(15),
          const SignupButtons(),
          const Gap(15),
          // SignUpVectorLine(),
        ],
      ),
    ).asGlass(frosted: true);
  }
}
