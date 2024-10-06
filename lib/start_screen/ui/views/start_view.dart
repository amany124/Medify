import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/app_images.dart';


class StartView extends StatelessWidget {
  const StartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            const Text(
              'Login to stay healthy and fit',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 66, 65, 65),
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(35),
            MaterialButton(
                height: 56,
                minWidth: 200,
                color: const Color(0xff407CE2),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
                onPressed: () {},
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )),
            const Gap(15),
            MaterialButton(
                height: 56,
                minWidth: 200,
                color: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: const BorderSide(
                    color: Color(0xff407CE2),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Sign up",
                  style: TextStyle(
                    color: Color(0xff407CE2),
                    fontSize: 14,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
