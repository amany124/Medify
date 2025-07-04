// import 'package:flutter/material.dart';
// import 'package:medify/features/chat/models/get_messages_response_model.dart';

// import '../../models/get_conversation_response_model.dart';

// class MessageBubble extends StatelessWidget {
//   const MessageBubble({
//     super.key,
//     // required this.message,
//     // required this.messageDate,
//     required this.messageData,
//   });

//   // final String message;
//   // final String messageDate;

//   static const _borderRadius = 26.0;
//   final GetMessagesResponseModel messageData;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               decoration: const BoxDecoration(
//                 color: Color(0xff356AF4),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(_borderRadius),
//                   bottomRight: Radius.circular(_borderRadius),
//                   bottomLeft: Radius.circular(_borderRadius),
//                 ),
//               ),
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
//                 child: Text(messageData.content ?? 'No message',
//                     style: const TextStyle(
//                       color: Color.fromARGB(255, 242, 245, 253),
//                     )),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Text(
//                 messageData.updatedAt.toString() ?? 'No date',
//                 style: const TextStyle(
//                   color: Color.fromARGB(255, 146, 146, 148),
//                   fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:medify/features/chat/models/get_messages_response_model.dart';

class MessageBubble extends StatelessWidget {
  static const _borderRadius = 26.0;

  final GetMessagesResponseModel messageData;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.messageData,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    // 💄 Styling that flips according to the sender
    final alignment =
        isMe ? Alignment.centerRight : Alignment.centerLeft; // side
    final bubbleColor = isMe ? const Color(0xff356AF4) : Colors.white; // colour
    final textColor = isMe ? Colors.white : const Color(0xff101623); // text
    final borderRadius = isMe
        ? const BorderRadius.only(
            // my bubble
            topLeft: Radius.circular(_borderRadius),
            bottomLeft: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(_borderRadius),
          )
        : const BorderRadius.only(
            // friend bubble
            topRight: Radius.circular(_borderRadius),
            bottomLeft: Radius.circular(_borderRadius),
            bottomRight: Radius.circular(_borderRadius),
          );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // 🗨️ bubble
            Container(
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: borderRadius,
              ),
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 14),
              constraints: const BoxConstraints(maxWidth: 280),
              child: Text(
                messageData.content,
                style: TextStyle(color: textColor),
              ),
            ),
            // 🕒 time
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 4.0, right: 4.0),
              child: Text(
                _formatDate(messageData.updatedAt),
                style: const TextStyle(
                  color: Color(0xff929294),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simple hh:mm formatter – switch to intl if you need locale handling.
  String _formatDate(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
