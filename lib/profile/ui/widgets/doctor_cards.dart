import 'package:flutter/material.dart';
//import 'package:graduation_project/core/utils/app_images.dart';
//import 'package:graduation_project/features/profile/ui/widgets/doctor_card.dart';

import '../../../core/utils/app_images.dart';
import 'doctor_card.dart';

class DoctorCards extends StatelessWidget {
  const DoctorCards({super.key});

  @override
  Widget build(BuildContext context) {
    // List of doctor data
    final List<DoctorCard> doctors = [
      const DoctorCard(
        name: 'Dr. Hamza Tariq',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $12',
        time: '10:30 AM-3:30 Today',
        rating: '4.9',
        specialization: 'Senior Surgeon',
      ),
      const DoctorCard(
        name: 'Dr. Alina Fatima',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $12',
        time: '10:30 AM-3:30 Next Sun',
        rating: '5.0',
        specialization: 'Senior Surgeon',
      ),
      const DoctorCard(
        name: 'Dr. Ali Uzair',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $15',
        time: '10:30 AM-3:30 Next Sat',
        rating: '4.8',
        specialization: 'Senior Surgeon',
      ),
      const DoctorCard(
        name: 'Dr. Ali Uzair',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $15',
        time: '10:30 AM-3:30 Next Sat',
        rating: '4.8',
        specialization: 'Senior Surgeon',
      ),
      const DoctorCard(
        name: 'Dr. Ali Uzair',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $15',
        time: '10:30 AM-3:30 Next Sat',
        rating: '4.8',
        specialization: 'Senior Surgeon',
      ),
      const DoctorCard(
        name: 'Dr. Ali Uzair',
        image: Assets.assetsImagesDoc,
        fee: r'Fee: $15',
        time: '10:30 AM-3:30 Next Sat',
        rating: '4.8',
        specialization: 'Senior Surgeon',
      ),
    ];

    return SliverList.builder(
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: doctors[index],
      ),
      itemCount: doctors.length,
    );
  }
}
