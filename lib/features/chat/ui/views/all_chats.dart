import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/chat/models/get_conversation_request_model.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/chats_list.dart';
import 'package:medify/features/chat/ui/widgets/search_bar.dart';

import '../../../../core/utils/keys.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              );
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
            SearchBarWidget(),
            Expanded(child: ChatsList()),
          ],
        ),
      ),
    );
  }
}
