import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/ProfileScreen/presentation/cubit/verify_doctor_cubit.dart';

/// Utility class for handling image picking functionality
class ImagePickerUtils {
  /// Show verification document image picker bottom sheet
  static void showVerificationImagePicker(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetHandle(),
              const SizedBox(height: 20),
              Text(
                'Select Verification Document',
                style: AppStyles.semiBold18.copyWith(color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: Colors.teal,
                    onTap: () => _pickVerificationImageFromCamera(ctx, cubit),
                  ),
                  _buildImagePickerOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: Colors.teal,
                    onTap: () => _pickVerificationImageFromGallery(ctx, cubit),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// Show profile picture image picker bottom sheet
  static void showProfilePictureImagePicker(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetHandle(),
              const SizedBox(height: 20),
              Text(
                'Update Profile Picture',
                style: AppStyles.semiBold18.copyWith(color: Colors.black87),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: Colors.blue,
                    onTap: () => _pickProfilePictureFromCamera(ctx, cubit),
                  ),
                  _buildImagePickerOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: Colors.blue,
                    onTap: () => _pickProfilePictureFromGallery(ctx, cubit),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// Show full size image dialog
  static void showFullSizeImage(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black,
          child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.8,
                child: InteractiveViewer(
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey.shade800,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline,
                                size: 64, color: Colors.white),
                            const SizedBox(height: 16),
                            Text(
                              'Failed to load image',
                              style: AppStyles.regular16.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Show general image picker bottom sheet
  static void showGeneralImagePicker(
    BuildContext context, {
    required Function(File) onImageSelected,
    String title = 'Select Image',
    String subtitle = 'Choose an image from camera or gallery',
    Color primaryColor = Colors.blue,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildBottomSheetHandle(),
              const SizedBox(height: 20),
              Text(
                title,
                style: AppStyles.semiBold18.copyWith(color: Colors.black87),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style:
                      AppStyles.regular14.copyWith(color: Colors.grey.shade600),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: primaryColor,
                    onTap: () => _pickImageFromSource(
                        ctx, ImageSource.camera, onImageSelected),
                  ),
                  _buildImagePickerOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: primaryColor,
                    onTap: () => _pickImageFromSource(
                        ctx, ImageSource.gallery, onImageSelected),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  /// Helper method to pick image from specified source
  static Future<void> _pickImageFromSource(
    BuildContext context,
    ImageSource source,
    Function(File) onImageSelected,
  ) async {
    Navigator.pop(context);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      // Handle error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Private helper methods

  static Widget _buildBottomSheetHandle() {
    return Container(
      width: 50,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  static Widget _buildImagePickerOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppStyles.semiBold14.copyWith(
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static void _pickVerificationImageFromCamera(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) async {
    Navigator.pop(context);
    await _pickImage(
      context,
      ImageSource.camera,
      (file) => cubit.verifyDoctorProfile(imageFile: file),
    );
  }

  static void _pickVerificationImageFromGallery(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) async {
    Navigator.pop(context);
    await _pickImage(
      context,
      ImageSource.gallery,
      (file) => cubit.verifyDoctorProfile(imageFile: file),
    );
  }

  static void _pickProfilePictureFromCamera(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) async {
    Navigator.pop(context);
    await _pickImage(
      context,
      ImageSource.camera,
      (file) => cubit.uploadDoctorProfilePicture(imageFile: file),
    );
  }

  static void _pickProfilePictureFromGallery(
    BuildContext context,
    VerifyDoctorCubit cubit,
  ) async {
    Navigator.pop(context);
    await _pickImage(
      context,
      ImageSource.gallery,
      (file) => cubit.uploadDoctorProfilePicture(imageFile: file),
    );
  }

  static Future<void> _pickImage(
    BuildContext context,
    ImageSource source,
    Function(File) onImagePicked,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);

      if (image != null) {
        onImagePicked(File(image.path));
      } else {
        if (context.mounted) {
          showCustomSnackBar('No image selected', context);
        }
      }
    } catch (e) {
      if (context.mounted) {
        showCustomSnackBar('Error picking image: ${e.toString()}', context);
      }
    }
  }
}
