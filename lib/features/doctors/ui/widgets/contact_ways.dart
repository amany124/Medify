import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import 'CustomBlueContainer.dart';

class DocContactWays extends StatelessWidget {
  const DocContactWays({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomBlueContainer(
          child: Row(
            children: [
              SvgPicture.asset(
                Assets.assetsImagesAddFav,
              ),
              const Gap(5),
              Text(
                'Add to Favorites',
                style: AppStyles.bold10.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        CustomBlueContainer(
          child: Row(
            children: [
              const Icon(
                Icons.add_card_outlined,
                color: Colors.white,
                size: 16,
              ),
              const Gap(5),
              Text(
                'Book Appointment',
                style: AppStyles.bold10.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const Gap(10),
        CustomBlueContainer(
          child: SvgPicture.asset(
            Assets.assetsImagesMessenger,
          ),
        )
      ],
    );
  }
}
