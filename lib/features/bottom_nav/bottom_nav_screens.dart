import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:medify/core/helpers/tapProvider.dart';
import 'package:provider/provider.dart';
import 'package:medify/features/chat/ui/views/all_chats.dart';
import 'package:medify/features/doctors/ui/views/doc_view.dart';
import 'package:medify/features/notification/ui/views/notification_page.dart';
import 'package:medify/features/social/ui/views/socail_page.dart';

import '../../core/di/di.dart';
import '../../core/helpers/local_data.dart';
import '../HeartAnaysis/ui/views/diseases_analysis.dart';
import '../chat/models/get_conversation_request_model.dart';
import '../chat/ui/chat_cubit/chat_cubit.dart';

class AllChatsPage extends StatelessWidget {
  const AllChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatCubit>()
        ..getConversation(
          requestModel: GetConversationRequestModel(
            token: LocalData.getAuthResponseModel()!.token,
          ),
        ),
      child: const AllChats(),
    );
  }
}

class BottomNavscreens extends StatelessWidget {
  const BottomNavscreens({super.key});

  static const pages = [
    HeartAnalysisPage(),
    SocailPage(),
    DocsView(),
    AllChatsPage(),
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
