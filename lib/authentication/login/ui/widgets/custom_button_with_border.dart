import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:medify/core/utils/app_images.dart';

class CustomButtonWithBorder extends StatelessWidget {
  const CustomButtonWithBorder({super.key, required this.icon, required this.text , });
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        elevation: 0,
        height: 56,
        minWidth: double.infinity,
        color: Colors.white,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 206, 205, 205),
          ),
        ),
        onPressed: () {},
        child: Row(
    
       
          children: [
             Gap(40),
            Image.asset(
             icon ,
             
              height: 35,
              width: 35,
            ),
            //  Gap(gap),
            Gap(30),
             Text(
           text ,  
              style:const TextStyle(
                color: Colors.black,
                fontSize: 16,
                  fontWeight: FontWeight.w900,
                fontFamily: 'Inter',
              
              ),
            ),
          ],
        ));
  }
}
