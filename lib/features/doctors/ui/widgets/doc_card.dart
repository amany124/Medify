import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/doctor_model.dart';
import '../views/DoctorPublicProfile.dart';
import 'favorite_icon.dart';

class DocCard extends StatelessWidget {
  final DoctorModel doctor;

  const DocCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DoctorProfile(
              doctor: doctor,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Card(
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: doctor.profilePicture.isNotEmpty
                        ? Image.network(
                            doctor.profilePicture,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: AppColors.iconBackColor,
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                              );
                            },
                          )
                        : Image.asset(
                            Assets.assetsImagesDoc,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(
                            'Dr. ${doctor.name}',
                            style: AppStyles.semiBold16.copyWith(
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        FavoriteIcon(
                          doctorId: doctor.id,
                          doctorName: doctor.name,
                          initialFavorite: doctor.isFavorite,
                        ),
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
                          Expanded(
                            child: Text(
                              doctor.specialty,
                              style: AppStyles.regular12.copyWith(
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
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
                            doctor.rating.toString(),
                            style: AppStyles.regular12.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          const Gap(12),
                          const Icon(
                            Icons.work_history_outlined,
                            color: AppColors.secondaryColor,
                            size: 14,
                          ),
                          const Gap(4),
                          Text(
                            '${doctor.experienceYears} ${doctor.experienceYears == 1 ? 'year' : 'years'}',
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
      ),
    );
  }
}
