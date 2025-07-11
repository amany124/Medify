import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/helpers/show_custom_snack_bar.dart';
import 'package:medify/core/utils/app_styles.dart';
import 'package:medify/features/social/data/models/update_post_request_model.dart';
import 'package:medify/features/social/ui/cubit/social_cubit.dart';

import '../../data/models/create_post_request_model.dart';

class CreatePostPage extends StatelessWidget {
  final bool isEditing;
  final String? contentText;
  final String? postId;
  const CreatePostPage(
      {super.key, this.isEditing = false, this.contentText, this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<SocialCubit>(),
      child: CreatePostView(
        isEditing: isEditing,
        contentText: contentText,
        postId: postId,
      ),
    );
  }
}

class CreatePostView extends StatefulWidget {
  final bool isEditing;
  final String? contentText;
  final String? postId;

  const CreatePostView(
      {super.key, required this.isEditing, this.contentText, this.postId});
  @override
  _CreatePostViewState createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  File? selectedImage;
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEditing && widget.contentText != null) {
      _contentController.text = widget.contentText!;
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  /// Show image picker bottom sheet
  void _showImagePickerBottomSheet() {
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
              const Gap(20),
              Text(
                'Add Image to Post',
                style: AppStyles.semiBold18.copyWith(color: Colors.black87),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildImagePickerOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: const Color(0xFF4285F4),
                    onTap: () => _pickImageFromCamera(ctx),
                  ),
                  _buildImagePickerOption(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    color: const Color(0xFF34A853),
                    onTap: () => _pickImageFromGallery(ctx),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetHandle() {
    return Container(
      width: 50,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildImagePickerOption({
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
            const Gap(8),
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

  Future<void> _pickImageFromCamera(BuildContext context) async {
    Navigator.pop(context);
    await _pickImage(ImageSource.camera);
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    await _pickImage(ImageSource.gallery);
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      } else {
        if (mounted) {
          showCustomSnackBar('No image selected', context);
        }
      }
    } catch (e) {
      if (mounted) {
        showCustomSnackBar('Error picking image: ${e.toString()}', context);
      }
    }
  }

  void _removeImage() {
    setState(() {
      selectedImage = null;
    });
  }

  Future<void> _editPost() async {
    if (_contentController.text.trim().isEmpty) {
      showCustomSnackBar(
          'Please write something before updating the post.', context);
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      final UpdatePostsRequestModel requestModel = UpdatePostsRequestModel(
        postId: widget.postId!,
        token: LocalData.getAuthResponseModel()!.token,
        content: _contentController.text,
      );

      await BlocProvider.of<SocialCubit>(context)
          .updatePost(requestModel: requestModel);

      if (mounted) {
        showCustomSnackBar('Post updated successfully!', context);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showCustomSnackBar('Error updating post: ${e.toString()}', context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  Future<void> _submitPost() async {
    final contentText = _contentController.text.trim();

    if (contentText.isEmpty) {
      showCustomSnackBar('Please write something before posting.', context);
      return;
    }

    final token = LocalData.getAuthResponseModel()?.token;
    if (token == null) {
      showCustomSnackBar('User not authenticated.', context);
      return;
    }

    setState(() {
      _isPosting = true;
    });

    try {
      final createPostRequest = CreatePostRequestModel(
        content: contentText,
        token: token,
        image: selectedImage,
      );

      await context.read<SocialCubit>().createPost(
            requestModel: createPostRequest,
          );

      if (mounted) {
        showCustomSnackBar('Post created successfully!', context);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        showCustomSnackBar('Error creating post: ${e.toString()}', context);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPosting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          widget.isEditing ? "Edit Post" : "Create Post",
          style: AppStyles.semiBold18.copyWith(color: Colors.black87),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: _isPosting
                ? null
                : (widget.isEditing ? _editPost : _submitPost),
            child: _isPosting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF4285F4)),
                    ),
                  )
                : Text(
                    widget.isEditing ? 'Update' : 'Post',
                    style: AppStyles.semiBold16.copyWith(
                      color: _contentController.text.trim().isEmpty
                          ? Colors.grey
                          : const Color(0xFF4285F4),
                    ),
                  ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Content input section
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // User info header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: const Color(0xFF4285F4),
                          child: Text(
                            LocalData.getAuthResponseModel()
                                    ?.user
                                    .name
                                    .substring(0, 1)
                                    .toUpperCase() ??
                                'U',
                            style: AppStyles.semiBold16
                                .copyWith(color: Colors.white),
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocalData.getAuthResponseModel()?.user.name ??
                                    'User',
                                style: AppStyles.semiBold16
                                    .copyWith(color: Colors.black87),
                              ),
                              const Gap(2),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'Public',
                                  style: AppStyles.medium12
                                      .copyWith(color: Colors.green.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content input field
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _contentController,
                        focusNode: _contentFocusNode,
                        maxLines: null,
                        expands: true,
                        textAlignVertical: TextAlignVertical.top,
                        style:
                            AppStyles.regular16.copyWith(color: Colors.black87),
                        decoration: InputDecoration(
                          hintText: "What's on your mind?",
                          hintStyle: AppStyles.regular16
                              .copyWith(color: Colors.grey.shade500),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: (value) {
                          setState(() {
                            // Trigger rebuild to update post button state
                          });
                        },
                      ),
                    ),
                  ),

                  // Selected image preview
                  if (selectedImage != null)
                    Container(
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              selectedImage!,
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: _removeImage,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  // Bottom actions
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: _buildActionButton(
                      icon: Icons.photo_camera,
                      label: 'Add Photo To Post',
                      color: const Color(0xFF4285F4),
                      onTap: _showImagePickerBottomSheet,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: color,
            ),
            const Gap(6),
            Text(
              label,
              style: AppStyles.medium14.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
