import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/routing/extensions.dart';
import 'package:medify/core/routing/routes.dart';
import 'package:medify/core/services/api_service.dart';
import 'package:medify/features/doctors/data/repos/favorite_doctors_repo.dart';
import 'package:medify/features/doctors/presentation/cubit/favorite_doctors_cubit.dart';

import '../../../../core/helpers/show_custom_snack_bar.dart';
import '../../../../core/utils/app_images.dart';
import '../../../../core/utils/app_styles.dart';
import 'CustomBlueContainer.dart';
import '../../data/models/doctor_model.dart';

class DocContactWaysWithFavorite extends StatelessWidget {
     final DoctorModel doctor;


  const DocContactWaysWithFavorite({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteDoctorsCubit(
        favoriteDoctorsRepo: FavoriteDoctorsRepoImpl(
          apiServices: ApiServices(Dio()),
        ),
      ),
      child: BlocConsumer<FavoriteDoctorsCubit, FavoriteDoctorsState>(
        listener: (context, state) {
          if (state is FavoriteActionError) {
            showCustomSnackBar(state.message, context);
          } else if (state is FavoriteActionSuccess) {
            showCustomSnackBar(state.message, context);
          }
        },
        builder: (context, state) {
          final bool isLoading = state is FavoriteActionLoading;

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: isLoading
                    ? null
                    : () => context
                        .read<FavoriteDoctorsCubit>()
                        .addDoctorToFavorites(doctor.id),
                child: CustomBlueContainer(
                  child: Row(
                    children: [
                      isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : SvgPicture.asset(
                              Assets.assetsImagesAddFav,
                            ),
                      const Gap(5),
                      Text(
                        'Add to Favorites',
                        style: AppStyles.bold10.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              InkWell(
                onTap: () {
                  context.pushNamed(Routes.appointment, arguments: doctor);
                },
                child: CustomBlueContainer(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_card_outlined,
                        color: Colors.white,
                        size: 16,
                      ),
                      const Gap(5),
                      Text(
                        'Book Appointmet',
                        style: AppStyles.bold10.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(10),
              InkWell(
                onTap: () {
                  context.pushNamed(Routes.allChats);
                },
                child: CustomBlueContainer(
                  child: SvgPicture.asset(
                    Assets.assetsImagesMessenger,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
