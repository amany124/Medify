import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/features/authentication/login/ui/widgets/navigate_gredient_button.dart';
import 'package:medify/features/authentication/login/ui/widgets/navigate_reverse_arrow.dart';

import '../../../congradulations/views/congradulations.dart';
//import 'package:medify/features/onboarding_screen/ui/widgets/dots.dart';

class NavigationSection extends StatelessWidget {
  const NavigationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Gap(40),
        Row(
          children: [
            ReverseArrow(
              onPressed: () {},
            ),
            const Gap(30),
            GradientButton(
              label: 'log into your Account',
              onpressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
                      builder: (context) => const CongratulationsView(
                        userName: 'Doctor',
                        isSignUp: false,
                        isdoctor: true,
                      ),
                    ));
<<<<<<< HEAD
=======
=======
                        builder: (context) => const CongratulationsView(
                            userName: 'Doctor',
                            isSignUp: false,
                            isdoctor: true)));
>>>>>>> de236dab746d84b8aa5bb357f3fd227e94364293
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
              },
            ),
          ],
        ),
      ],
<<<<<<< HEAD
    );
=======
    )
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
  }
}
