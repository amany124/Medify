import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Dots extends StatelessWidget {
  const Dots({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.circle,size: 11,color: Colors.blue,),
        Gap(10),
        Icon(Icons.circle,size: 11,color: Color(0xffE7EAEB),),
        Gap(10),
        Icon(Icons.circle,size: 11,color: Color(0xffE7EAEB),),

      ],
    );
  }
}