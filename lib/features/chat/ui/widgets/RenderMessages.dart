import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/MessageBubble.dart';
import 'package:medify/features/chat/ui/widgets/chats_list.dart';

class RenderMessages extends StatelessWidget {
  const RenderMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId = LocalData.getAuthResponseModel()?.user.id.toString();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) {
          // Only rebuild when message-related states change
          return current is MessagesLoadingState ||
              current is MessagesErrorState ||
              current is MessagesLoadedState ||
              current is SendingMessageState ||
              current is MessageSentSuccessState ||
              current is MessageSendErrorState;
        },
        builder: (context, state) {
          if (state is MessagesLoadingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else if (state is MessagesErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load messages',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.errorMessage,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ChatCubit>().refreshMessages();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is MessagesLoadedState) {
            final messages = state.messages;

            if (messages.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.chat_bubble_outline,
                      size: 64,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No messages yet',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start the conversation by sending a message',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              reverse: true, // Show newest messages at bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message =
                    messages[messages.length - 1 - index]; // Reverse order
                final isMe = message.senderId == currentUserId;
                return MessageBubble(
                  messageData: message,
                  isMe: isMe, // Pass the isMe flag for proper alignment
                );
              },
            );
          }

          // Initial state or other states
          return const Center(
            child: SizedBox.shrink(),
          );
        },
      ),
    );
  }
}
