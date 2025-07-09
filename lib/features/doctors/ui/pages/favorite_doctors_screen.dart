import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/doctors/data/models/favorite_doctor_model.dart';
import 'package:medify/features/doctors/data/repos/favorite_doctors_repo.dart';
import 'package:medify/features/doctors/presentation/cubit/favorite_doctors_cubit.dart';

import '../../../../core/utils/app_colors.dart';

class FavoriteDoctorsScreen extends StatelessWidget {
  const FavoriteDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteDoctorsCubit(
        favoriteDoctorsRepo: FavoriteDoctorsRepoImpl(
          apiServices: ApiServices(Dio()),
        ),
      )..getFavoriteDoctors(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Favorite Doctors',
            style: AppStyles.bold20.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.primaryColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const FavoriteDoctorsContent(),
      ),
    );
  }
}

class FavoriteDoctorsContent extends StatelessWidget {
  const FavoriteDoctorsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteDoctorsCubit, FavoriteDoctorsState>(
      builder: (context, state) {
        if (state is FavoriteDoctorsLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.secondaryColor,
              strokeWidth: 3.5,
            ),
          );
        } else if (state is FavoriteDoctorsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60,
                  color: Colors.red[300],
                ),
                const Gap(16),
                Text(
                  state.message,
                  style: AppStyles.medium16,
                  textAlign: TextAlign.center,
                ),
                const Gap(24),
                ElevatedButton(
                  onPressed: () {
                    context.read<FavoriteDoctorsCubit>().getFavoriteDoctors();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 3,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 18,
                      ),
                      const Gap(8),
                      Text(
                        'Retry',
                        style: AppStyles.medium14.copyWith(
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is FavoriteDoctorsLoaded) {
          final doctors = state.doctors;

          if (doctors.isEmpty) {
            return _buildEmptyState(context);
          }

          return _buildDoctorsList(doctors);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: AppColors.secondaryColor.withValues(alpha: 0.7),
          ),
          const Gap(20),
          Text(
            'No favorite doctors yet',
            style: AppStyles.semiBold18.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'You haven\'t added any doctors to your favorites list yet',
              style: AppStyles.regular14.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const Gap(30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              elevation: 3,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 18,
                ),
                const Gap(8),
                Text(
                  'Explore Doctors',
                  style: AppStyles.medium14.copyWith(
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsList(List<FavoriteDoctorModel> doctors) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${doctors.length} ${doctors.length == 1 ? 'Doctor' : 'Doctors'} in your favorites',
                  style: AppStyles.medium14.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const Gap(8),
                Divider(
                  color: Colors.grey[300],
                ),
                const Gap(8),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final doctor = doctors[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: FavoriteDoctorCard(doctor: doctor),
                );
              },
              childCount: doctors.length,
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Gap(80),
        ),
      ],
    );
  }
}

class FavoriteDoctorCard extends StatelessWidget {
  final FavoriteDoctorModel doctor;

  const FavoriteDoctorCard({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    // Doctor image
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.iconBackColor,
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: doctor.profileImage != null &&
                                doctor.profileImage!.isNotEmpty
                            ? Image.network(
                                doctor.profileImage!,
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
                            : Container(
                                color: AppColors.iconBackColor,
                                child: const Icon(
                                  Icons.person,
                                  size: 40,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                      ),
                    ),
                    const Gap(16),
                    // Doctor info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  doctor.name,
                                  style: AppStyles.semiBold16.copyWith(
                                    color: AppColors.primaryColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  context
                                      .read<FavoriteDoctorsCubit>()
                                      .removeDoctorFromFavorites(doctor.id);
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: Colors.red[400],
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          const Gap(4),
                          Text(
                            doctor.specialization,
                            style: AppStyles.regular14.copyWith(
                              color: AppColors.secondaryColor,
                            ),
                          ),
                          const Gap(8),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 18,
                              ),
                              const Gap(4),
                              Text(
                                doctor.rating.toString(),
                                style: AppStyles.medium12.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              const Gap(16),
                              const Icon(
                                Icons.work_history_outlined,
                                color: AppColors.secondaryColor,
                                size: 16,
                              ),
                              const Gap(4),
                              Text(
                                doctor.experience != null
                                    ? '${doctor.experience} ${doctor.experience == 1 ? 'year' : 'years'}'
                                    : 'N/A',
                                style: AppStyles.medium12.copyWith(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // const Gap(12),
                // Actions row
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     _buildActionButton(
                //       context,
                //       icon: Icons.calendar_month_outlined,
                //       label: 'Book',
                //       onTap: () {
                //         // Navigate to book appointment
                //         context.pushNamed(Routes.appointment,
                //             arguments: doctor );
                //       },
                //     ),
                //     Container(
                //       width: 1,
                //       height: 30,
                //       color: Colors.grey[300],
                //     ),
                //     _buildActionButton(
                //       context,
                //       icon: Icons.chat_outlined,
                //       label: 'Chat',
                //       onTap: () {
                //         // Navigate to chat
                //         context.pushNamed(Routes.allChats);
                //       },
                //     ),
                //     Container(
                //       width: 1,
                //       height: 30,
                //       color: Colors.grey[300],
                //     ),
                //     _buildActionButton(
                //       context,
                //       icon: Icons.info_outline,
                //       label: 'Details',
                //       onTap: () {
                //         // Navigate to doctor details
                //         context.pushNamed(Routes.doctorPublicProfile,
                //             arguments: doctor);
                //       },
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppColors.primaryColor,
              size: 20,
            ),
            const Gap(4),
            Text(
              label,
              style: AppStyles.medium12.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
