import 'package:flutter/material.dart';
import 'package:medify/core/utils/app_images.dart';

class Avatar extends StatelessWidget {
  double radius = 22;
  String? networkurl;
  String? image;
  Avatar({
    super.key,
    // required this.networkurl,
    required this.radius,
    this.image,
  });

  Avatar.small({
    super.key,
    //Key? key,
    // required this.networkurl,
    this.radius = 20,
    this.image,
  });

  Avatar.medium({
    super.key,
    //Key? key,
    //  required this.networkurl,
    this.radius = 27,
    this.image,
  });

  Avatar.large({
    super.key,
    //Key? key,
    // required this.networkurl,
    this.radius = 44,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color.fromARGB(255, 251, 223, 223),
      backgroundImage: const AssetImage(Assets.femalepic2),
    );
  }
}

class AvatarWithOnlineCircle extends StatelessWidget {
  const AvatarWithOnlineCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        radius: 28,
        backgroundColor: Color.fromARGB(255, 251, 223, 223),
        backgroundImage: AssetImage(Assets.femalepic2),
        child: Stack(children: [
          Align(
              alignment: Alignment.bottomRight,
              child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.white,
                  child:
                      CircleAvatar(radius: 16, backgroundColor: Colors.green)))
        ]));
  }
}

class AvatarWithIcon extends StatelessWidget {
  const AvatarWithIcon({super.key});

  // IconData? icon;
  // AvatarWithIcon({this.icon});
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
        radius: 28,
        backgroundColor: Color.fromARGB(255, 251, 223, 223),
        backgroundImage: AssetImage(Assets.femalepic1),
        child: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 17,
                ) // change this children
                ),
          ),
        ]));
  }
}
