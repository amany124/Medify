import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/doctors/data/repos/favorite_doctors_repo.dart';
import 'package:medify/features/doctors/data/repos/review_repo.dart';
import 'package:medify/features/doctors/presentation/cubit/favorite_doctors_cubit.dart';
import 'package:medify/features/doctors/presentation/cubit/review_cubit.dart';
import 'package:medify/features/doctors/ui/widgets/review_dialog.dart';

import '../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../core/theme/app_colors.dart';

class FavoriteIcon extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final bool initialFavorite;

  const FavoriteIcon({
    super.key,
    required this.doctorId,
    required this.doctorName,
    this.initialFavorite = false,
  });

  @override
  State<FavoriteIcon> createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorite;
  late final FavoriteDoctorsCubit _favoriteCubit;
  late final ReviewCubit _reviewCubit;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialFavorite;

    // Initialize the cubits
    _favoriteCubit = FavoriteDoctorsCubit(
      favoriteDoctorsRepo: FavoriteDoctorsRepoImpl(
        apiServices: ApiServices(Dio()),
      ),
    );

    _reviewCubit = ReviewCubit(
      reviewRepo: ReviewRepoImpl(
        apiServices: ApiServices(Dio()),
      ),
    );
  }

  @override
  void dispose() {
    _favoriteCubit.close();
    _reviewCubit.close();
    super.dispose();
  }

  void _toggleFavorite() {
    setState(() {
      isLoading = true;
    });

    if (isFavorite) {
      _favoriteCubit.removeDoctorFromFavorites(widget.doctorId);
    } else {
      _favoriteCubit.addDoctorToFavorites(widget.doctorId);
    }
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: _reviewCubit,
        child: ReviewDialog(
          doctorId: widget.doctorId,
          doctorName: widget.doctorName,
        ),
      ),
    ).then((wasReviewed) {
      if (wasReviewed == true) {
        // Optionally refresh any data after review is submitted
        // _reviewCubit.fetchReviews(widget.doctorId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoriteDoctorsCubit, FavoriteDoctorsState>(
      bloc: _favoriteCubit,
      listener: (context, state) {
        if (state is FavoriteActionSuccess) {
          setState(() {
            isFavorite = !isFavorite;
            isLoading = false;
          });
          showCustomSnackBar(state.message, context, isError: false);
        } else if (state is FavoriteActionError) {
          setState(() {
            isLoading = false;
          });
          showCustomSnackBar(state.message, context, isError: true);
        }
      },
      child: Row(
        children: [
          InkWell(
            onTap: isLoading ? null : _toggleFavorite,
            borderRadius: BorderRadius.circular(50),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.primaryColor,
                      ),
                    )
                  : Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
            ),
          ),
          const SizedBox(width: 10),
          FadeIn(
            child: InkWell(
              onTap: _showReviewDialog,
              borderRadius: BorderRadius.circular(50),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.rate_review_outlined,
                  size: 20,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
