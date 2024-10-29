import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  double radius = 22;
  String? networkurl;
  String? image;
  Avatar({
    Key? key,
    // required this.networkurl,
    required this.radius,
    this.image,
  }) : super(key: key);

  Avatar.small({
    Key? key,
    // required this.networkurl,
    this.radius = 20,
    this.image,
  });

  Avatar.medium({
    Key? key,
    //  required this.networkurl,
    this.radius = 27,
    this.image,
  });

  Avatar.large({
    Key? key,
    // required this.networkurl,
    this.radius = 44,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundImage: AssetImage('assets/images/doc_test2.png'),
    );
  }
}

class AvatarWithOnlineCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 28,
        backgroundColor: Color.fromARGB(255, 251, 223, 223),
        backgroundImage: AssetImage('assets/images/doc_test2.png'),
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
  // IconData? icon;
  // AvatarWithIcon({this.icon});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
        radius: 28,
        backgroundImage: AssetImage('assets/images/doc_test2.png'),
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
