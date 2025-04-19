import 'package:flutter/material.dart';
import '../../../../core/utils/app_styles.dart';

class IntroductionCard extends StatelessWidget {
  const IntroductionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      height: 128,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Consult to your ',
            style: AppStyles.semiBold14.copyWith(
              color: const Color(0xff577CEF),
            ),
          ),
          Text(
            'Medify',
            style: AppStyles.semiBold24.copyWith(
              color: const Color(0xff577CEF),
            ),
          ),
          Text(
            'healthcare',
            style: AppStyles.semiBold18.copyWith(
              color: const Color(0xff577CEF),
            ),
          ),
        ],
      ),
    );
  }
}