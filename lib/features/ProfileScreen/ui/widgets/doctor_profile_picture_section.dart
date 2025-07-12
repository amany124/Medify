import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/core/widgets/custom_button.dart';
import 'package:medify/core/widgets/custom_shimmer.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_cubit.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_state.dart';
import 'package:medify/features/ProfileScreen/ui/cubit/get_profile_cubit.dart';
import 'package:medify/features/authentication/register/data/models/doctor_model.dart';

import '../utils/image_picker_utils.dart';

/// Widget for doctor profile picture section
class DoctorProfilePictureSection extends StatelessWidget {
  final DoctorModel doctor;
  final bool isEditing;
  final VoidCallback? onEditPressed;

  const DoctorProfilePictureSection({
    super.key,
    required this.doctor,
    this.isEditing = false,
    this.onEditPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            Colors.blue.shade50.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade100.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Picture Header with name and edit button
          ProfilePictureHeaderWidget(
            name: doctor.name,
            onEditPressed: onEditPressed,
            isEditing: isEditing,
          ),
          const SizedBox(height: 16),

          // Upload Button or Image Preview
          BlocConsumer<VerifyDoctorCubit, VerifyDoctorState>(
            listener: _handleProfilePictureStateChange,
            builder: (context, state) {
              return Column(
                children: [
                  // Profile Image
                  Center(
                    child: _hasProfilePicture()
                        ? ProfilePicturePreview(
                            imageUrl: doctor.profilePicture!)
                        : ProfilePictureUploadButton(state: state),
                  ),

                  // Action Button (shown only if there's a profile picture)
                  if (_hasProfilePicture()) const SizedBox(height: 16),

                  if (_hasProfilePicture()) _buildActionButton(context, state),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  bool _hasProfilePicture() {
    return doctor.profilePicture != null && doctor.profilePicture!.isNotEmpty;
  }

  Widget _buildActionButton(BuildContext context, VerifyDoctorState state) {
    final bool isLoading = state is ProfilePictureUploadLoading;

    return CustomButton(
      text: isLoading ? 'Updating...' : 'Change Profile Picture',
      backgroundColor: isLoading ? Colors.grey.shade400 : Colors.blue.shade600,
      textColor: Colors.white,
      buttonWidth: double.infinity,
      onPressed: isLoading
          ? () {} // Disabled when loading
          : () => ImagePickerUtils.showProfilePictureImagePicker(
                context,
                context.read<VerifyDoctorCubit>(),
              ),
    );
  }

  void _handleProfilePictureStateChange(
      BuildContext context, VerifyDoctorState state) {
    if (state is ProfilePictureUploadSuccess) {
      showCustomSnackBar(
        'Profile picture updated successfully!',
        context,
      );
      // Refresh the doctor profile to show updated profile picture
      context.read<GetProfileCubit>().getDoctorProfile();
    } else if (state is ProfilePictureUploadError) {
      showCustomSnackBar(
        'Upload failed: ${state.message}',
        context,
      );
    }
  }
}

/// Header widget for profile picture section
class ProfilePictureHeaderWidget extends StatelessWidget {
  final String? name;
  final VoidCallback? onEditPressed;
  final bool isEditing;

  const ProfilePictureHeaderWidget({
    super.key,
    this.name,
    this.onEditPressed,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.blue.shade600,
            Colors.blue.shade500,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? 'Profile Picture',
                  style: AppStyles.semiBold18.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  name != null
                      ? 'Doctor Profile'
                      : 'Upload or update your professional profile image',
                  style: AppStyles.regular12.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          if (onEditPressed != null)
            GestureDetector(
              onTap: onEditPressed,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isEditing ? Icons.cancel : Icons.edit,
                  color: !isEditing
                      ? Colors.white
                      : Colors.red.withValues(alpha: 0.8),
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Upload button widget for profile picture
class ProfilePictureUploadButton extends StatelessWidget {
  final VerifyDoctorState state;

  const ProfilePictureUploadButton({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Placeholder Image with Shimmer
        ProfilePictureShimmer(
          radius: 60,
          baseColor: Colors.blue.shade100,
          highlightColor: Colors.white.withValues(alpha: 0.8),
        ),
        const SizedBox(height: 16),

        // Upload Button
        CustomButton(
          text: state is ProfilePictureUploadLoading
              ? 'Uploading...'
              : 'Upload Profile Picture',
          backgroundColor: state is ProfilePictureUploadLoading
              ? Colors.grey.shade400
              : Colors.blue.shade600,
          textColor: Colors.white,
          buttonWidth: 200,
          onPressed: state is ProfilePictureUploadLoading
              ? () {} // Disabled when loading
              : () => ImagePickerUtils.showProfilePictureImagePicker(
                    context,
                    context.read<VerifyDoctorCubit>(),
                  ),
        ),
      ],
    );
  }
}

/// Image preview widget for profile picture
class ProfilePicturePreview extends StatelessWidget {
  final String imageUrl;

  const ProfilePicturePreview({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.blue.shade300, width: 3),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade100.withValues(alpha: 0.4),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: _buildImageContent(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () =>
                  ImagePickerUtils.showFullSizeImage(context, imageUrl),
              child: Text(
                'View Full Size',
                style: AppStyles.regular12.copyWith(
                  color: Colors.blue.shade700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return ProfilePictureShimmer(
            radius: 60,
            baseColor: Colors.blue.shade100,
            highlightColor: Colors.white.withValues(alpha: 0.8),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorContainer();
        },
      );
    } else {
      return _buildInvalidUrlContainer();
    }
  }

  Widget _buildErrorContainer() {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 36, color: Colors.grey.shade400),
          const SizedBox(height: 4),
          Text(
            'Failed to load',
            style: AppStyles.regular10.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInvalidUrlContainer() {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person, size: 36, color: Colors.grey.shade400),
          const SizedBox(height: 4),
          Text(
            'Invalid image',
            style: AppStyles.regular10.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
