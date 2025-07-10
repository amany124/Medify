import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_images.dart';
import 'package:medify/core/widgets/custom_shimmer.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';

class ProfileAppbarContent extends StatefulWidget {
  const ProfileAppbarContent({
    super.key,
    required this.name,
    this.profilePicture,
    this.onProfilePictureUpdate,
  });
  final String name;
  final String? profilePicture;
  final VoidCallback? onProfilePictureUpdate;

  @override
  State<ProfileAppbarContent> createState() => _ProfileAppbarContentState();
}

class _ProfileAppbarContentState extends State<ProfileAppbarContent> {
  bool _isImageLoading = false;
  bool _hasImageError = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Stack(
          children: [
            _buildProfilePicture(),
            if (widget.onProfilePictureUpdate != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: widget.onProfilePictureUpdate,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade600,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          widget.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          CacheManager.getData(key: Keys.role),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildProfilePicture() {
    if (_isImageLoading) {
      return ProfilePictureShimmer(
        radius: 60, // Increased from 50 to 60
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.white.withValues(alpha: 0.8),
      );
    }

    if (_hasImageError ||
        widget.profilePicture == null ||
        widget.profilePicture!.isEmpty) {
      return CircleAvatar(
        radius: 60, // Increased from 50 to 60
        backgroundImage: const AssetImage(Assets.femalepic2),
      );
    }

    return CircleAvatar(
      radius: 60, // Increased from 50 to 60
      backgroundColor: Colors.grey.shade200,
      child: ClipOval(
        child: Image.network(
          widget.profilePicture!,
          width: 120, // 60 * 2
          height: 120, // 60 * 2
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() => _isImageLoading = false);
                }
              });
              return child;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() => _isImageLoading = true);
              }
            });

            return ProfilePictureShimmer(
              radius: 60,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white.withValues(alpha: 0.8),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                setState(() {
                  _hasImageError = true;
                  _isImageLoading = false;
                });
              }
            });

            return CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage(Assets.femalepic2),
            );
          },
        ),
      ),
    );
  }
}
