import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../core/utils/app_images.dart';

class HeartDiseases extends StatelessWidget {
  const HeartDiseases({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.blueColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Heart Diseases',
          style: AppStyles.bold22.copyWith(
            color: AppColors.blueColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                'Everything you need to know about heart disease...',
                style: AppStyles.bold16.copyWith(
                  color: Colors.black,
                ),
              ),
              const Gap(3),
              Image.asset(Assets.assetsImagesHeartDiseases,width: 250,),
              const Gap(5),
              Text(
                'According to the Centers for Disease Control and Prevention (CDC), heart disease is the leading cause of death in the United States. Around 1 in 4 deathsTrusted Source in the U.S. occur due to heart disease, and the condition affects all genders as well as all racial and ethnic groups.',
                style: AppStyles.regular16.copyWith(
                  color: Colors.black,
                ),
              ),
              const Gap(3),
              Text(
                'Types of heart disease...',
                style: AppStyles.bold22.copyWith(
                  color: Colors.black,
                ),
              ),
              const Gap(3),
               Text(
                  'Heart disease refers to any condition affecting the cardiovascular system. There are several different types of heart disease, and they affect the heart and blood vessels in different ways',
                  style: AppStyles.regular16.copyWith(
                  color: Colors.black,
                ),),
                const Gap(5),
              Image.asset(Assets.assetsImagesTypes,
              //width: 700,
              //height: 200,
              
              ),
            ],
          ),
        ),
      ),
    );
  }
}
