import 'package:flutter/material.dart';

import 'package:medify/core/helpers/tapProvider.dart';
import 'package:provider/provider.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/social/ui/views/socail_page.dart';

import '../HeartAnaysis/ui/views/diseases_analysis.dart';

class BottomNavscreens extends StatelessWidget {
  const BottomNavscreens({super.key});

  static const pages = [
    HeartAnalysisPage(),
    SocailPage(),
    DocsView(),
    AllChats(),
    NotificationView(),
  ];

  @override
  Widget build(BuildContext context) {
    int currentindex = context.watch<tapProvider>().currentindex;
    return IndexedStack(
      index: currentindex,
      children: pages,
    );
  }
}

// class wid extends StatelessWidget {
//   const wid({super.key, required this.message});
//   final String message;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text(message),
//       ),
//       bottomNavigationBar: bottomnavigationContent(),
//     );
//   }
// }
