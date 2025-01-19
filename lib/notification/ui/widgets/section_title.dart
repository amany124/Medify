// import 'package:flutter/material.dart';

// class SectionTitle extends StatelessWidget {
//   const SectionTitle({
//     super.key, required this.title,
//   });
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:
//       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(25),
//         color: const Color(0xffCAD6FF),
//       ),
//       //color: const Color(0xffCAD6FF),
//       child: Text(
//         title,
//         style: const TextStyle(
//           color: Color(0xff2260FF),
//           fontSize: 18,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xffCAD6FF),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Color(0xff2260FF),
          ),
        ),
      ),
    );
  }
}
