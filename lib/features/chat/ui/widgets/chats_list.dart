import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/core/helpers/cache_manager.dart';
import 'package:medify/core/utils/keys.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/chat_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key, this.onReturnFromMessages});

  final VoidCallback? onReturnFromMessages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) {
        // Only rebuild when conversation-related states change
        return current is ConversationsLoadingState ||
            current is ConversationsErrorState ||
            current is ConversationsLoadedState;
      },
      builder: (context, state) {
        if (state is ConversationsLoadingState) {
          return CustomLoading();
        } else if (state is ConversationsErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error loading conversations',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.errorMessage,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    final token = CacheManager.getData(key: Keys.token) ?? '';
                    context.read<ChatCubit>().loadConversations(
                          token: token,
                        );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is ConversationsLoadedState) {
          if (state.conversations.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4285F4).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Color(0xFF4285F4),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "No conversations yet",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Start a conversation with a doctor",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            itemBuilder: (context, index) {
              final message = state.conversations[index];

              return ChatItem(
                messageData: message,
                onReturnFromMessages: onReturnFromMessages,
              );
            },
            itemCount: state.conversations.length,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
        color: const Color(0xFF4285F4),
        size: 50,
      ),
    );
  }
}
