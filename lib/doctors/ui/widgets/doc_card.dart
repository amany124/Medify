import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../views/DoctorPublicProfile.dart';
import 'favorite_icon.dart';

class DocCard extends StatelessWidget {
  const DocCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DoctorProfile(),
              ),
            );
          },
      child: Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.asset(
                Assets.assetsImagesDoc,
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(
                        'Dr. Rahma Ahmed',
                        style: AppStyles.semiBold16.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      const FavoriteIcon(),
                    ]),
                    const Gap(5),
                    //divider
                    Divider(
                      color: AppColors.primaryColor.withOpacity(0.8),
                      thickness: 0.5,
                      height: 10,
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        Text(
                          'Senior Surgeon | The City Hospital',
                          style: AppStyles.regular12.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const Gap(5),
                    Row(
                      children: [
                        SvgPicture.asset(
                          Assets.assetsImagesStar,
                        ),
                        const Gap(8),
                        Text(
                          '4.9',
                          style: AppStyles.regular12.copyWith(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}