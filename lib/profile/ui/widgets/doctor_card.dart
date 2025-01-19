import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.name,
    required this.image,
    required this.fee,
    required this.time,
    required this.rating,
    required this.specialization,
  });
  final String name;
  final String image;
  final String fee;
  final String time;
  final String rating;
  final String specialization;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      //  shape: ,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Image.asset(
              image,
            ),
            const Gap(18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: AppStyles.semiBold16.copyWith(
                          // color: AppColors.blueColor,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      // star icon
                      const Icon(
                        Icons.star,
                        color: Colors.amberAccent,
                        size: 16,
                      ),
                      const Gap(2),
                      Text(
                        rating,
                        style: AppStyles.regular14.copyWith(
                          // color: AppColors.blueColor,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  const Gap(3),
                  Text(
                    specialization,
                    style: AppStyles.regular14.copyWith(
                      // color: AppColors.blueColor,
                      color: const Color(0xff9C9C9C),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const Gap(3),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              //stop watch icon
                              const Icon(
                                Icons.watch_later_outlined,
                                color: Color(0xff333333),
                                size: 16,
                              ),
                              const Gap(3),
                              Text(
                                time,
                                //'10:30 AM-3:30 Today',
                                style: AppStyles.regular14.copyWith(
                                  // color: AppColors.blueColor,
                                  color: const Color(0xff333333),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            fee,
                            //r'Fee: $12',
                            style: AppStyles.semiBold14.copyWith(
                              // color: AppColors.blueColor,
                              color: const Color(0xff9C9C9C),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.center,
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: SvgPicture.asset(
                          Assets.assetsImagesArrowRight,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
