import 'package:flutter/material.dart';
import 'package:medify/features/chat/models/send_message_request_model.dart';
import 'package:medify/features/chat/ui/widgets/customPrefixIcon.dart';
import 'package:medify/features/chat/ui/widgets/custumCircleButton.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/local_data.dart';
import '../../models/get_conversation_response_model.dart';
import '../chat_cubit/chat_cubit.dart';

class ChatTextField extends StatefulWidget {
  const ChatTextField({
    super.key,
    required this.messageData,
  });

  final GetConversationResponseModel messageData;

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final conentController = TextEditingController();

  @override
  void dispose() {
    conentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              width: 290,
              height: 58,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1.5,
                    blurRadius: 1,
                    offset: const Offset(
                        3, 4), // changes the position of the shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  controller: conentController,
                  //textAlign: TextAlign.justify,
                  decoration: InputDecoration(
                    prefixIcon: customPrefixIcon(),
                    hintText: 'Type your message here ...',
                    hintStyle: TextStyle(
                      fontSize: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        custumCircleButton(
          ontap: () {
            context.read<ChatCubit>().sendMessage(
                  requestModel: SendMessageRequestModel(
                    receiverId:
                        widget.messageData.lastMessage?.receiverId ?? '',
                    content: conentController.text,
                    token: LocalData.getAuthResponseModel()!.token,
                  ),
                );
            conentController.clear();
          },
        ),
      ],
    );
  }
}
