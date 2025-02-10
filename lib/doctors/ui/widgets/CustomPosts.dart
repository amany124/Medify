import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
 import 'package:gradient_borders/gradient_borders.dart';
import '../../../../core/utils/app_images.dart';
import '../../../core/utils/app_styles.dart';

class Customposts extends StatelessWidget {
  const Customposts({
    super.key,
    required this.name,
    required this.content,
    required this.date,
    required this.share,
    required this.like,
    required this.comment,
    required this.eye,
  });
  final String name;
  final String content;
  final String date;
  final String share;
  final String like;
  final String comment;
  final String eye;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(8),
        border: GradientBoxBorder(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 8, 209, 216),
              const Color(0xff1877F2),
              const Color(0xff1877F2).withOpacity(0.8),
            ],
           ),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: AssetImage(Assets.assetsImagesCat),
            ),
            title: Text(
              name,
              style: AppStyles.semiBold14.copyWith(
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              date,
              style: AppStyles.regular10.copyWith(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            trailing: const Icon(Icons.more_vert),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              content,
              style: AppStyles.regular14.copyWith(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.remove_red_eye, size: 18),
                    const Gap(4),
                    Text(
                     eye ,
                      style: AppStyles.regular12.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.share, size: 18),
                    const Gap(4),
                    Text(
                      share,
                      style: AppStyles.regular12.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.comment, size: 18),
                    const Gap(4),
                    Text(
                      comment,
                      style: AppStyles.regular12.copyWith(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.thumb_up, size: 18),
                    const Gap(4),
                    Text(
                      like,
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
    );
  }
}
