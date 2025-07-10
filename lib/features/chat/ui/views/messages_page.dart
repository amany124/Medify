import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/di/di.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/AppBarTitle.dart';
import 'package:medify/features/chat/ui/widgets/ChatTextField.dart';
import 'package:medify/features/chat/ui/widgets/RenderMessages.dart';
import 'package:medify/features/chat/ui/widgets/icon_buttons.dart';

import '../../../../core/helpers/cache_manager.dart';
import '../../../../core/utils/keys.dart';
import '../../models/get_conversation_response_model.dart';

class MessagesPage extends StatelessWidget {
  static Route route(GetConversationResponseModel data) {
    // Get current user ID
    final currentUserId = LocalData.getAuthResponseModel()?.user.id.toString();

    // Determine the other user ID (the one we're chatting with)
    String otherUserId = '';
    if (data.lastMessage?.senderId == currentUserId) {
      // If current user sent the last message, chat with the receiver
      otherUserId = data.lastMessage?.receiverId ?? '';
    } else {
      // If someone else sent the last message, chat with the sender
      otherUserId = data.lastMessage?.senderId ?? '';
    }

    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: getIt<ChatCubit>()
          ..initializeChatConversation(
            userId: otherUserId,
            token: CacheManager.getData(key: Keys.token) ?? '',
          ),
        child: MessagesPage(
          messageData: data,
        ),
      ),
    );
  }

  const MessagesPage({
    super.key,
    required this.messageData,
    
  });

  final GetConversationResponseModel messageData;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is MessageSentSuccessState) {
          // Messages will automatically refresh after sending
          // No additional action needed here
        } else if (state is MessageSendErrorState) {
          // Show error message if needed
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to send message: ${state.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF3F4F8),
        appBar: AppBar(
          toolbarHeight: 90,
          //  iconTheme: Theme.of(context).iconTheme,
          centerTitle: false,
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconBackground(
              icon: CupertinoIcons.back,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          title: AppBarTitle(
            messageData: messageData,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.video_camera_solid,
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Center(
                child: IconBorder(
                  icon: CupertinoIcons.phone_solid,
                  onTap: () {},
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: RenderMessages(),
            ),
            ChatTextField(
              messageData: messageData,
            ),
          ],
        ),
      ),
    );
  }
}
