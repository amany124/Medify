import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Dots extends StatelessWidget {
  const Dots({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle,size: 8,color: Colors.blue,),
        Gap(5),
        Icon(Icons.circle,size: 8,color: Colors.grey,),
        Gap(5),
        Icon(Icons.circle,size: 8,color: Colors.grey,),

      ],
    );
  }
}