import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.radius = 53,
    required this.url,
  });
  final double radius;
  final String url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: NetworkImage(
        url,
      ),
    );
  }
}
