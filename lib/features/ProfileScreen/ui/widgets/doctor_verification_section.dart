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

/// Widget for doctor verification section
class DoctorVerificationSection extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorVerificationSection({
    super.key,
    required this.doctor,
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
            Colors.teal.shade50.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.teal.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header and instructions (only shown if not verified)
          if (_shouldShowUploadSection())
            Column(
              children: [
                const VerificationHeaderWidget(),
                const SizedBox(height: 20),
                const UploadInstructionsWidget(),
                const SizedBox(height: 16),
              ],
            ),

          // Upload Button or Image Preview
          BlocConsumer<VerifyDoctorCubit, VerifyDoctorState>(
            listener: _handleVerificationStateChange,
            builder: (context, state) {
              if (_hasVerificationImage()) {
                return VerificationImagePreview(
                  imageUrl: doctor.verificationImage!,
                );
              } else {
                return VerificationUploadButton(state: state);
              }
            },
          ),
        ],
      ),
    );
  }

  bool _shouldShowUploadSection() {
    return doctor.verificationImage == null ||
        doctor.verificationImage!.isEmpty;
  }

  bool _hasVerificationImage() {
    return doctor.verificationImage != null &&
        doctor.verificationImage!.isNotEmpty;
  }

  void _handleVerificationStateChange(
      BuildContext context, VerifyDoctorState state) {
    if (state is VerifyDoctorSuccess) {
      showCustomSnackBar(
        'Verification document uploaded successfully!',
        context,
      );
      // Refresh the doctor profile to show updated verification image
      context.read<GetProfileCubit>().getDoctorProfile();
    } else if (state is VerifyDoctorError) {
      showCustomSnackBar(
        'Upload failed: ${state.message}',
        context,
      );
    }
  }
}

/// Header widget for verification section
class VerificationHeaderWidget extends StatelessWidget {
  const VerificationHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.teal.shade600,
            Colors.teal.shade500,
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
              Icons.verified_user,
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
                  'Doctor Verification',
                  style: AppStyles.semiBold18.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Upload credentials for verification',
                  style: AppStyles.regular12.copyWith(
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange, width: 1.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.pending, size: 16, color: Colors.orange),
                const SizedBox(width: 4),
                Text(
                  'Pending',
                  style: AppStyles.semiBold10.copyWith(color: Colors.orange),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Upload instructions widget
class UploadInstructionsWidget extends StatelessWidget {
  const UploadInstructionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal.shade200),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Colors.teal.shade600, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Verification Requirements',
                  style: AppStyles.semiBold14
                      .copyWith(color: Colors.teal.shade700),
                ),
                const SizedBox(height: 4),
                Text(
                  'Upload a clear image of your medical license or certification',
                  style:
                      AppStyles.regular12.copyWith(color: Colors.teal.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Upload button widget
class VerificationUploadButton extends StatelessWidget {
  final VerifyDoctorState state;

  const VerificationUploadButton({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: state is VerifyDoctorLoading
          ? 'Uploading...'
          : 'Upload Verification Document',
      backgroundColor: state is VerifyDoctorLoading
          ? Colors.grey.shade400
          : Colors.teal.shade600,
      textColor: Colors.white,
      buttonWidth: double.infinity,
      onPressed: state is VerifyDoctorLoading
          ? () {} // Disabled when loading
          : () => ImagePickerUtils.showVerificationImagePicker(
                context,
                context.read<VerifyDoctorCubit>(),
              ),
    );
  }
}

/// Image preview widget for verification documents
class VerificationImagePreview extends StatelessWidget {
  final String imageUrl;

  const VerificationImagePreview({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview Label
        Row(
          children: [
            Icon(Icons.verified, color: Colors.green.shade600, size: 20),
            const SizedBox(width: 8),
            Text(
              'Verification Document',
              style: AppStyles.semiBold14.copyWith(
                color: Colors.green.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Image Preview Container
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.green.shade100.withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: _buildImageContent(),
          ),
        ),
        const SizedBox(height: 12),

        // Action Buttons
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildImageContent() {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return RectangularShimmer(
            width: double.infinity,
            height: 200,
            borderRadius: 10,
            baseColor: Colors.grey.shade300,
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
          Icon(Icons.error_outline, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'Failed to load image',
            style: AppStyles.regular12.copyWith(
              color: Colors.grey.shade600,
            ),
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
          Icon(Icons.image, size: 48, color: Colors.grey.shade400),
          const SizedBox(height: 8),
          Text(
            'Invalid image URL',
            style: AppStyles.regular12.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'View Full Size',
            backgroundColor: Colors.green.shade50,
            textColor: Colors.green.shade700,
            buttonWidth: double.infinity,
            buttonHeight: 40,
            onPressed: () =>
                ImagePickerUtils.showFullSizeImage(context, imageUrl),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: CustomButton(
            text: 'Replace Image',
            backgroundColor: Colors.orange.shade50,
            textColor: Colors.orange.shade700,
            buttonWidth: double.infinity,
            buttonHeight: 40,
            onPressed: () => ImagePickerUtils.showVerificationImagePicker(
              context,
              context.read<VerifyDoctorCubit>(),
            ),
          ),
        ),
      ],
    );
  }
}
