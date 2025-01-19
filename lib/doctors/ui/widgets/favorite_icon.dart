import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_images.dart';

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon({
    super.key,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFavorite = !isFavorite;
        });
      },
      child: SvgPicture.asset(
        Assets.assetsImagesFavoriteIcon,
        colorFilter: isFavorite
            ? const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              )
            : null,
      ),
    );
  }
}
