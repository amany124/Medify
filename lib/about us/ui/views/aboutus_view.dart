import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../core/utils/app_images.dart';
import '../widgets/about_container.dart';
import '../widgets/contact_us.dart';

class AboutusView extends StatelessWidget {
  const AboutusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'About Us !',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image section
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Image.asset(Assets.assetsImagesAboutImage),
              ),
              const Gap(20),
              // Description text
              const ContainerText(
                text1: 'Medify',
                text2:
                    "We strive to provide innovative digital solutions for monitoring and diagnosing heart diseases, with the goal of improving patients' quality of life by enabling them to closely track their health, access medical consultations, and effectively connect with doctors. Our aim is to empower users to make informed health decisions and respond quickly to symptoms to maintain their well-being.",
              ),
              const Gap(20),
              const ContainerText(
                text1: 'Our Mission',
                text2:
                    "We strive to provide innovative digital solutions for monitoring and diagnosing heart diseases, with the goal of improving patients' quality of life by enabling them to closely track their health, access medical consultations, and effectively connect with doctors. Our aim is to empower users to make informed health decisions and respond quickly to symptoms to maintain their well-being.",
              ),
              const Gap(20),
              const ContainerText(
                text1: 'Our Vission',
                text2:
                    "We strive to provide innovative digital solutions for monitoring and diagnosing heart diseases, with the goal of improving patients' quality of life by enabling them to closely track their health, access medical consultations, and effectively connect with doctors. Our aim is to empower users to make informed health decisions and respond quickly to symptoms to maintain their well-being.",
              ),

              const Gap(50),
              const ContactUs(),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: AppStyles.bold22.copyWith(
          color: AppColors.blueColor,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
        color: AppColors.blueColor,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(56);
}
