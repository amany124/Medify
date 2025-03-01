import 'package:flutter/material.dart';

// ignore: must_be_immutable, camel_case_types
class custumCircleButton extends StatelessWidget {
  VoidCallback? ontap;
  custumCircleButton({super.key, this.ontap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, bottom: 5),
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: ontap,
          ),
        ),
      ),
    );
  }
}
