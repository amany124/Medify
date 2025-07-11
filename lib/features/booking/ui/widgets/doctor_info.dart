import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/app_images.dart';
import '../../../doctors/data/models/doctor_model.dart';

class DoctorInfoSection extends StatelessWidget {
  const DoctorInfoSection({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
          color: const Color(0xff1877F2).withOpacity(0.8),
          // borderRadius: BorderRadius.vertical(
          //   bottom: Radius.circular(20),
          // ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(110),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main doctor info row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Doctor Image with shadow effect and verified badge
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: doctor.profilePicture.isNotEmpty
                          ? Image.network(
                              doctor.profilePicture,
                              width: 120,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              Assets.assetsImagesDoctor,
                              width: 120,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  // Verified badge
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),

              // Doctor information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Doctor Name with title
                    Row(
                      children: [
                        Text(
                          "Dr. ",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            doctor.name,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const Gap(4),

                    // Specialty with badge
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            doctor.specialty,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const Gap(6),
                        Expanded(
                          child: Text(
                            doctor.specialization,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const Gap(12),

                    // Rating with stars
                    Row(
                      children: [
                        ...List.generate(5, (index) {
                          return Icon(
                            index < doctor.rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          );
                        }),
                        const Gap(8),
                        Text(
                          "(${doctor.rating.toStringAsFixed(1)})",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    const Gap(12),

                    // Experience
                    Row(
                      children: [
                        const Icon(
                          Icons.work_outline,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const Gap(4),
                        Text(
                          "${doctor.experienceYears} years of experience",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),

                    const Gap(4),

                    // Clinic name
                    Row(
                      children: [
                        const Icon(
                          Icons.local_hospital_outlined,
                          color: Colors.white70,
                          size: 16,
                        ),
                        const Gap(4),
                        Expanded(
                          child: Text(
                            doctor.clinicName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action buttons column
              Column(
                children: [
                  _buildActionButton(
                    icon: Icons.favorite_outline,
                    color: Colors.white,
                    label: "Favorite",
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.email_outlined,
                    color: Colors.white,
                    label: "Email",
                    onTap: () {},
                  ),
                  _buildActionButton(
                    icon: Icons.message_outlined,
                    color: Colors.white,
                    label: "Message",
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              height: 1,
              color: Colors.white.withOpacity(0.2),
            ),
          ),

          // Clinic address and brief about
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.white,
                size: 18,
              ),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Clinic Address:",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      doctor.clinicAddress,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white70,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),

          // About preview
          if (doctor.about.isNotEmpty) ...[
            const Gap(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 18,
                ),
                const Gap(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About Doctor:",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        doctor.about.length > 100
                            ? "${doctor.about.substring(0, 100)}..."
                            : doctor.about,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    String? label,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Tooltip(
        message: label ?? "",
        child: IconButton(
          icon: Icon(icon, color: color),
          onPressed: onTap,
          constraints: const BoxConstraints(
            minWidth: 42,
            minHeight: 42,
          ),
          padding: EdgeInsets.zero,
          iconSize: 20,
          splashRadius: 24,
        ),
      ),
    );
  }
}
