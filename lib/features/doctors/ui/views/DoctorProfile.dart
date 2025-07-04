import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glass/glass.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/services/api_service.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../data/models/doctor_model.dart';
import '../../data/repos/doctor_public_profile_repo.dart';
import '../../presentation/cubit/doctor_public_profile_cubit.dart';
import '../widgets/IconWithText.dart';
import '../widgets/doc_contact_ways_with_favorite.dart';
import '../widgets/doctor_post_card.dart';

class DoctorProfile extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorProfile({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DoctorPublicProfileCubit(
        doctorPublicProfileRepo: DoctorPublicProfileRepoImpl(
          apiServices: ApiServices(Dio()),
        ),
      )..getDoctorPublicProfile(doctor.id),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff1877F2),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Doctor Profile",
            style: TextStyle(
              color: Color(0xff1877F2),
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        ),
        body: BlocBuilder<DoctorPublicProfileCubit, DoctorPublicProfileState>(
          builder: (context, state) {
            if (state is DoctorPublicProfileLoading) {
              return _buildLoadingState();
            } else if (state is DoctorPublicProfileError) {
              return _buildErrorState(context, state.message);
            } else if (state is DoctorPublicProfileLoaded) {
              return SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage(
                        Assets.assetsImagesBackgroundProfile,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 50.0,
                                left: 10,
                                right: 10,
                                bottom: 10,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Dr. ${state.profile.doctor.name}',
                                        style: AppStyles.medium16.copyWith(
                                          color: Colors.black,
                                        ),
                                      ),
                                      const Gap(8),
                                      const Icon(
                                        Icons.verified,
                                        color: Color(0xff1877F2),
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Heart Specialist',
                                    style: AppStyles.regular12.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const Gap(5),
                                  DocContactWaysWithFavorite(doctor: doctor),
                                  const Gap(12),
                                  const CustomIconWithText(
                                    icon: Icons.person,
                                    text:
                                        'Member of the Egyptian Society of Cardiology',
                                  ),
                                  const Gap(5),
                                  const CustomIconWithText(
                                    icon: Icons.location_on,
                                    text: 'Cairo, Egypt',
                                  ),
                                ],
                              ),
                            ).asGlass(
                                tintColor: Colors.white,
                                blurX: 10,
                                blurY: 10,
                                clipBorderRadius: BorderRadius.circular(20)),
                            const Positioned(
                              top: -50,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 50,
                                backgroundImage: AssetImage(
                                  Assets.assetsImagesDoctor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Gap(24),
                        // Posts heading
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Doctor's Posts",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1877F2),
                              ),
                            ),
                          ),
                        ),
                        const Gap(12),
                        // Doctor Posts
                        if (state.profile.posts.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.note_alt_outlined,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                  const Gap(16),
                                  Text(
                                    'No posts available',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.profile.posts.length,
                            itemBuilder: (context, index) {
                              return DoctorPostCard(
                                post: state.profile.posts[index],
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  // Loading state with shimmer effect
  Widget _buildLoadingState() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
        child: Column(
          children: [
            // Profile card shimmer
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 50.0,
                    left: 10,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -50,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Gap(24),
            // Posts heading shimmer
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 20,
                width: 150,
                margin: const EdgeInsets.only(left: 8, bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            // Posts shimmer
            for (int i = 0; i < 3; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Error state
  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 80,
            color: Colors.red,
          ),
          const Gap(16),
          const Text(
            'Error loading profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const Gap(8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
          ),
          const Gap(24),
          ElevatedButton.icon(
            onPressed: () {
              // Retry loading the profile
              context
                  .read<DoctorPublicProfileCubit>()
                  .getDoctorPublicProfile(doctor.id);
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1877F2),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
