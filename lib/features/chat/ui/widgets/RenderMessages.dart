// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:medify/features/chat/models/getMessages_request_model.dart';
// import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
// import 'package:medify/features/chat/ui/widgets/DateLable.dart';
// import 'package:medify/features/chat/ui/widgets/FreindMessageBubble.dart';
// import 'package:medify/features/chat/ui/widgets/MessageBubble.dart';

// class RenderMessages extends StatelessWidget {
//   const RenderMessages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 8.0),
//       child: BlocBuilder<ChatCubit, ChatState>(
//         builder: (context, state) {
//           if (state is GetMessagesLoading) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is GetMessagesError) {
//             return Center(
//               child: Text(state.message),
//             );
//           } else if (state is GetMessagesSuccess) {
//             final messages = state.messagesList;

//             if (messages.isEmpty) {
//               return Center(
//                 child: Text("No messages found"),
//               );
//             }

//             return ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final message = messages[index];
//                 return MessageBubble(
//                   messageData: message,
//                 );
//               },
//             );
//           }

//           return SizedBox.shrink();
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/features/chat/ui/chat_cubit/chat_cubit.dart';
import 'package:medify/features/chat/ui/widgets/MessageBubble.dart';

class RenderMessages extends StatelessWidget {
  const RenderMessages({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserId =
        LocalData.getAuthResponseModel()?.user.id.toString(); // 👈️ your id

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is GetMessagesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetMessagesError) {
            return Center(child: Text(state.message));
          } else if (state is GetMessagesSuccess) {
            final messages = state.messagesList;

            if (messages.isEmpty) {
              return const Center(child: Text('No messages found'));
            }

            return ListView.builder(
              reverse: true,                         // newest at bottom
              padding: const EdgeInsets.only(top: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final isMe = msg.senderId == currentUserId;
                return MessageBubble(
                  messageData: msg,
                  isMe: isMe,                       // 👈️ pass the flag
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
