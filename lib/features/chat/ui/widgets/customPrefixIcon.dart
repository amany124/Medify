
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customPrefixIcon extends StatelessWidget {
  const customPrefixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                width: 2,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: const Padding(
            padding:  EdgeInsets.only(right: 7.0),
            child: Icon(
              CupertinoIcons.camera_fill,
            ),
          ),
        ),
      ],
    );
  }
}
