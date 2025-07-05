import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/tapProvider.dart';
import 'package:medify/features/HeartAnaysis/data/repo/heart_repo.dart';
import 'package:medify/features/HeartAnaysis/ui/views/heart_analysis_page.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/social/ui/views/socail_page.dart';

import '../../core/widgets/bottom_navigation_content.dart';
import '../HeartAnaysis/ui/cubit/heart_analysis_cubit.dart';

class BottomNavscreens extends StatelessWidget {
  const BottomNavscreens({super.key});

  @override
  Widget build(BuildContext context) {
    int currentindex = context.watch<tapProvider>().currentindex;
    // the widget returns page based on current index from tap provider
    return Scaffold(
      body: IndexedStack(
        index: currentindex,
        children: [
          BlocProvider(
            create: (_) => HeartAnalysisCubit(
              HeartAnalysisRepo(Dio()),
            ),
            child: HeartAnalysisPage(),
          ),
          SocailPage(),
          TopDoctorsView(),
          AllChats(),
          NotificationView(),
        ],
      ),
      bottomNavigationBar: const BottomnavigationContent(),
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
