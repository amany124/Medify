import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/chats_list.dart';

import '../../../../core/utils/keys.dart';

class AllChats extends StatefulWidget {
  const AllChats({super.key});

  @override
  State<AllChats> createState() => _AllChatsState();
}

class _AllChatsState extends State<AllChats> {
  late final ChatCubit _chatCubit;

  @override
  void initState() {
    super.initState();
    _chatCubit = getIt<ChatCubit>();
    _loadConversations();
  }

  void _loadConversations() {
    // Check if the cubit is still active before loading
    if (!_chatCubit.isClosed) {
      _chatCubit.loadConversations(
        token: CacheManager.getData(key: Keys.token) ?? '',
      );
    }
  }

  // This method will be called when returning from MessagesPage
  void _onReturnFromMessages() {
    // Check if we need to refresh the conversations
    // We'll refresh if the current state is not already showing conversations
    if (_chatCubit.state is! ConversationsLoadedState && !_chatCubit.isClosed) {
      _loadConversations();
    }
  }

  @override
  void dispose() {
    // Don't close the cubit here as it might be used by other parts of the app
    // The DI container will handle the lifecycle
    super.dispose();
  }

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
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer<void>();

          // Listen for state changes to complete the refresh
          late StreamSubscription subscription;
          subscription = _chatCubit.stream.listen((state) {
            if (state is ConversationsLoadedState ||
                state is ConversationsErrorState) {
              if (!completer.isCompleted) {
                completer.complete();
              }
              subscription.cancel();
            }
          });

          _loadConversations();

          // Timeout after 10 seconds
          return completer.future.timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              subscription.cancel();
            },
          );
        },
        child: BlocProvider.value(
          value: _chatCubit,
          child: Column(
            children: [
              // SearchBarWidget(),
              const SizedBox(height: 8),
              Expanded(
                child: ChatsList(
                  onReturnFromMessages: _onReturnFromMessages,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
