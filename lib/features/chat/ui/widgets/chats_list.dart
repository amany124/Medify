import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:medify/features/chat/models/messageModel.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/chat_item.dart';

import '../../../../core/helpers/helpers.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is GetConversationLoading) {
          return Center(
            child: LoadingAnimationWidget.threeRotatingDots(
              color: const Color(0xff223A6A),
              size: 50,
            ),
          );
        } else if (state is GetConversationError) {
          return Center(
            child: Text(state.message),
          );
        } else if (state is GetConversationSuccess) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final message = state.conversationsList[index];

              return ChatItem(
                messageData: message,
              );
            },
            itemCount: state.conversationsList.length,
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
