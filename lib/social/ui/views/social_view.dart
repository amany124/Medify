import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:medify/chat/ui/widgets/search_bar.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';
import 'package:medify/social/ui/widgets/post_widget.dart';
import 'package:medify/social/ui/widgets/stories.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
                  'Medify',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff223A6A),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
                Gap(20),
                Expanded(child: SearchBarWidget()),
        //         CircleAvatar(
        //   radius: 20,
        //   backgroundImage: AssetImage('assets/images/female pic1.jpg'),
        // ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
          actions: [
          
        //   // SearchBarWidget(),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(CupertinoIcons.bell),
          //   splashRadius: 21,
          // ),
        //   // IconButton(
        //   //   onPressed: () {},
        //   //   icon: const Icon(CupertinoIcons.paperplane),
        //   //   splashRadius: 21,
        //   // ),
          //  Gap(10),
       ],
      ),
      body: ListView(
        children: const [
          // Stories(),
          Divider(thickness: 0.6),
          Post(
            username: "Amany alzanfaly",
            timestamp: "2 hours ago",
            content:
                "Dream big, work hard, stay focused, and surround yourself with good energy.",
            imageUrl:
                "https://th.bing.com/th/id/R.883a4952998ca380853326bc61805259?rik=eMV9tHDVFS63Mw&pid=ImgRaw&r=0",
          ),
          Post(
            username: "Amany alzanfaly",
            timestamp: "1 day ago",
            content: "Keep pushing forward, no matter how hard it gets.",
            imageUrl:
                "https://th.bing.com/th/id/OIP.372HTY_zy6Hzf3s8KtEB6wAAAA?w=474&h=316&rs=1&pid=ImgDetMain",
          ),
          Post(
            username: "Amany alzanfaly",
            timestamp: "3 days ago",
            content:
                "Eating healthy food is very important not only for having a healthy life but also protecting our hearts.",
            imageUrl:
                "https://th.bing.com/th/id/OIP.k1trY7GGyoZw5nSWHkn2AQHaFf?w=640&h=475&rs=1&pid=ImgDetMain",
          ),
        ],
      ),
      bottomNavigationBar: bottomnavigationContent(),
   
    );
  }
}








// ...existing code...
// import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.black54),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search, color: Colors.black54),
        ),
      ),
    );
  }
}
// // ...existing code...
// appBar: AppBar(
//         title: Row(
//           children: [
//             const Text(
//                   'Medify',
//                   style: TextStyle(
//                     fontSize: 24,
//                     color: Color(0xff223A6A),
//                     fontWeight: FontWeight.w600,
//                     fontFamily: 'Poppins',
//                   ),
//                 ),
//             const SizedBox(width: 5),
//             Expanded(child: SearchBarWidget()),
//           ],
//         ),
// // ...existing code...