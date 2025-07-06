import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/chat/models/get_conversation_request_model.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/chats_list.dart';

import '../../../../core/utils/keys.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF1A1A1A),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF1A1A1A),
            ),
            onPressed: () {
              // Add more options here
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => getIt<ChatCubit>()
          ..getConversation(
            requestModel: GetConversationRequestModel(
              token: CacheManager.getData(key: Keys.token) ?? '',
            ),
          ),
        child: const Column(
          children: [
            // SearchBarWidget(),
            SizedBox(height: 8),
            Expanded(child: ChatsList()),
          ],
        ),
      ),
    );
  }
}
