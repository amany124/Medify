import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePickerWidget extends StatelessWidget {
  final Function(File image) onImageSelected;

  const CustomImagePickerWidget({super.key, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();

    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Open gallery'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.gallery);
            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Open camera'),
          onTap: () async {
            final pickedFile =
                await picker.pickImage(source: ImageSource.camera);
            if (pickedFile != null) {
              onImageSelected(File(pickedFile.path));
            }
          },
        ),
      ],
    );
  }
}
