import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:glass/glass.dart';
import 'package:medify/features/doctors/ui/widgets/doctor_profile_verfied.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/services/api_service.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/keys.dart';
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
            ), // No actions needed
          ),
          body: BlocBuilder<DoctorPublicProfileCubit, DoctorPublicProfileState>(
            builder: (context, state) {
              if (state is DoctorPublicProfileLoading) {
                return _buildLoadingState();
              } else if (state is DoctorPublicProfileError) {
                return _buildErrorState(state.message);
              } else if (state is DoctorPublicProfileLoaded) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.8,
                      image: AssetImage(
                        Assets.assetsImagesBackgroundProfile,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, top: 50, bottom: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.only(
                                  top: 60.0,
                                  left: 20,
                                  right: 20,
                                  bottom: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha:0.05),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Dr. ${state.profile.doctor.name}',
                                          style: AppStyles.medium16.copyWith(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Gap(8),
                                        DoctorProfileVerfied(),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: const Color(0xff1877F2)
                                            .withValues(alpha:0.1),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Text(
                                        'Heart Specialist',
                                        style: AppStyles.regular12.copyWith(
                                          color: const Color(0xff1877F2),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    if (CacheManager.getData(key: Keys.role) !=
                                        'Doctor')
                                      DocContactWaysWithFavorite(
                                        doctor: doctor,
                                      ),
                                    const Gap(12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha:0.6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withValues(alpha:0.2)),
                                      ),
                                      child: const CustomIconWithText(
                                        icon: Icons.person,
                                        text:
                                            'Member of the Egyptian Society of Cardiology',
                                      ),
                                    ),
                                    const Gap(8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha:0.6),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color:
                                                Colors.grey.withValues(alpha:0.2)),
                                      ),
                                      child: const CustomIconWithText(
                                        icon: Icons.location_on,
                                        text: 'Cairo, Egypt',
                                      ),
                                    ),
                                  ],
                                ),
                              ).asGlass(
                                  tintColor: Colors.white,
                                  blurX: 20,
                                  blurY: 20,
                                  frosted: true,
                                  clipBorderRadius: BorderRadius.circular(24)),
                              Positioned(
                                top: -50,
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha:0.1),
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                      Assets.assetsImagesDoctor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Gap(16),
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
        ));
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
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha:0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
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
            const Gap(16),
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
  Widget _buildErrorState(String message) {
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
              BlocProvider.of<DoctorPublicProfileCubit>(
                      GlobalObjectKey(doctor).currentContext!)
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
