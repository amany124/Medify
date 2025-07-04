import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/core/theme/app_colors.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/doctors/data/repos/doctors_repo.dart';
import 'package:medify/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../data/repos/favorite_doctors_repo.dart';
import '../../presentation/cubit/favorite_doctors_cubit.dart';
import '../widgets/doc_card.dart';

class TopDoctorsView extends StatelessWidget {
  const TopDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DoctorsCubit(
            doctorsRepo: DoctorsRepoImpl(
              apiServices: ApiServices(Dio()),
            ),
          )..searchDoctors(),
        ),
        BlocProvider(
          create: (context) => FavoriteDoctorsCubit(
        favoriteDoctorsRepo: FavoriteDoctorsRepoImpl(
          apiServices: ApiServices(Dio()),
        ),
      ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Top Rated Doctors',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<DoctorsCubit, DoctorsState>(
              listener: (context, state) {
                if (state is DoctorsError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    const Gap(14),
                    _buildSearchBar(context),
                    const Gap(15),
                    _buildFilterRow(),
                    const Gap(15),
                    Expanded(
                      child: _buildDoctorsList(context, state),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            color: AppColors.primaryColor,
          ),
          const Gap(8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search doctors, specialties...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
              onChanged: (query) {
                if (query.length > 2) {
                  context.read<DoctorsCubit>().searchDoctors(
                        searchQuery: query,
                      );
                }
              },
            ),
          ),
          InkWell(
            onTap: () {
              // Clear search
              context.read<DoctorsCubit>().searchDoctors();
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.close,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Specializations',
              style: AppStyles.semiBold14.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildFilterChip(context, 'All', true),
                _buildFilterChip(context, 'Cardiology', false),
                _buildFilterChip(context, 'Neurology', false),
                _buildFilterChip(context, 'Dermatology', false),
                _buildFilterChip(context, 'Pediatrics', false),
                _buildFilterChip(context, 'Orthopedics', false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        selectedColor: isSelected
            ? AppColors.secondaryColor.withValues(alpha: 0.2)
            : Colors.grey[200],
        checkmarkColor: AppColors.secondaryColor,
        label: Text(label),
        backgroundColor: Colors.grey[200],
        labelStyle: AppStyles.regular12.copyWith(
          color: isSelected ? AppColors.secondaryColor : Colors.black,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? AppColors.secondaryColor : Colors.transparent,
            width: 1.0,
          ),
        ),
        elevation: isSelected ? 1 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        onSelected: (selected) {
          if (selected && label != 'All') {
            // Filter by specialization
            final cubit = BlocProvider.of<DoctorsCubit>(context);
            cubit.searchDoctors(specialization: label);
          } else {
            // Show all doctors
            BlocProvider.of<DoctorsCubit>(context).searchDoctors();
          }
        },
      ),
    );
  }

  Widget _buildDoctorsList(BuildContext context, DoctorsState state) {
    if (state is DoctorsLoading) {
      return _buildLoadingShimmer();
    } else if (state is DoctorsLoaded) {
      if (state.doctors.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search_off,
                size: 80,
                color: Colors.grey[400],
              ),
              const Gap(16),
              Text(
                'No doctors found',
                style: AppStyles.semiBold18.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const Gap(8),
              Text(
                'Try adjusting your search or filters',
                style: AppStyles.regular14.copyWith(
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      return RefreshIndicator(
        onRefresh: () async {
          await context.read<DoctorsCubit>().searchDoctors();
        },
        color: AppColors.secondaryColor,
        child: ListView.builder(
          itemCount: state.doctors.length,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemBuilder: (context, index) {
            final doctor = state.doctors[index];
            return DocCard(doctor: doctor);
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
