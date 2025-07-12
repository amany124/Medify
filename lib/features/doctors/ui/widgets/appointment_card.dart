import 'package:flutter/material.dart';
import 'package:medify/features/ProfileScreen/ui/views/simple_patient_profile_screen.dart';
import 'package:medify/features/authentication/register/data/models/patient_model.dart';

//import 'package:graduation_project/core/utils/app_images.dart';

import '../../../../core/utils/app_images.dart';

class AppointmentCard extends StatelessWidget {
  final PatientModel? patient;

  const AppointmentCard({
    super.key,
    this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          if (patient != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModernPatientProfileScreen(
                  patient: patient!,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              // Patient/Doctor Image
              CircleAvatar(
                radius: 30,
                backgroundImage: const AssetImage(Assets.assetsImagesDoctor),
                child: patient == null
                    ? null
                    : const Icon(Icons.person, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 15),
              // Appointment Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Appointment cancelled",
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Wed, 17 May | 08.30 AM",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      patient?.name ?? "Dr. Randy Wigham",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text(
                      "General Medical Checkup",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 5),
                        Text(
                          "4.8 ",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Tap indicator
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
