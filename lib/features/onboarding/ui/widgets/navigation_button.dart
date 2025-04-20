import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_styles.dart';
import '../views/start_view.dart';
//import 'package:graduation_project/core/utils/app_styles.dart';
//import 'package:graduation_project/features/onboarding/ui/views/start_view.dart';

class NavigationButton extends StatelessWidget {
  const NavigationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.arrow_back,
          //     color: Colors.blue,
          //   ),
          // ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StartView()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff0062ff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
              child: Row(
                children: [
                  Text(
                    'Next',
                    style: AppStyles.regular18,
                  ),
                  const Gap(10),
                  const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
