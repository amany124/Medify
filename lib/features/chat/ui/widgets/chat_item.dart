import 'package:flutter/material.dart';
import 'package:medify/features/chat/models/messageModel.dart';
import 'package:medify/features/chat/ui/views/messages_page.dart';
import 'package:medify/core/widgets/avatar.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
    required this.messageData,
  });

  final messageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () {
         Navigator.of(context).push(MessagesPage.route(messageData));
        },
        splashColor:const Color.fromARGB(255, 248, 245, 245),
        child: Container(
          height: 100,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right:22, ),
                  child: AvatarWithOnlineCircle(),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          messageData.senderName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            letterSpacing: 0.2,
                            wordSpacing: 1.5,
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                        child: Text(
                          messageData.messageContent,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        messageData.dateMessage,
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: -0.2,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 18,
                        height: 18,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(221, 255, 255, 255),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
