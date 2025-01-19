import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            color: Colors.white,
            elevation: 4,
            //  shape: ,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13.0,
                vertical: 3.5,
              ),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: SvgPicture.asset(
                    Assets.assetsImagesSearch,
                    height: 18,
                    width: 18,
                  ),
                  hintText: "Search previous appointments",
                  hintStyle: AppStyles.regular12.copyWith(
                    color: const Color(0xff000000),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(33),
        SvgPicture.asset(
          Assets.assetsImagesFilter,
        )
      ],
    );
  }
}
