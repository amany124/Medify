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
