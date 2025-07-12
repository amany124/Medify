import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/utils/app_styles.dart';

/// Heart Analysis specific image picker utility
class HeartAnalysisImagePicker {
  /// Show ECG image picker bottom sheet for heart analysis
  static void showECGImagePicker(
    BuildContext context,
    Function(File) onImageSelected,
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
                'Upload ECG Image',
                style: AppStyles.semiBold18.copyWith(color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                'Select an ECG image for heart analysis',
                style:
                    AppStyles.regular14.copyWith(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    context,
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: const Color(0xFF1E88E5),
                    onTap: () => _pickImageFromCamera(ctx, onImageSelected),
                  ),
                  _buildImagePickerOption(
                    context,
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: const Color(0xFF1E88E5),
                    onTap: () => _pickImageFromGallery(ctx, onImageSelected),
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

  /// Build bottom sheet handle widget
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

  /// Build image picker option widget
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
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: AppStyles.semiBold14.copyWith(
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Pick image from camera
  static Future<void> _pickImageFromCamera(
    BuildContext context,
    Function(File) onImageSelected,
  ) async {
    Navigator.pop(context);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image from camera: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  /// Pick image from gallery
  static Future<void> _pickImageFromGallery(
    BuildContext context,
    Function(File) onImageSelected,
  ) async {
    Navigator.pop(context);
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        onImageSelected(File(pickedFile.path));
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error picking image from gallery: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
