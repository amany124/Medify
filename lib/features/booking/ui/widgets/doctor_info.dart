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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: const Color(0xff1877F2).withOpacity(0.8),
          // borderRadius: BorderRadius.vertical(
          //   bottom: Radius.circular(20),
          // ),
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(110),
          )),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              Assets.assetsImagesDoctor,
              width: 120,
              height: 240,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(16),
          // النصوص وتقييم النجوم
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  doctor.specialty,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const Gap(8),
                Row(
                  children: List.generate(doctor.rating.toInt() , (index) {
                    return const Icon(Icons.star,
                        color: Colors.yellow, size: 20);
                  }),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.email, color: Colors.white),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.message, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
