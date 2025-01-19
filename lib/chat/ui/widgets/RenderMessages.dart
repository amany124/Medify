
import 'package:flutter/material.dart';
import 'package:medify/chat/ui/widgets/DateLable.dart';
import 'package:medify/chat/ui/widgets/FreindMessageBubble.dart';
import 'package:medify/chat/ui/widgets/MessageBubble.dart';

class RenderMessages extends StatelessWidget {
  const RenderMessages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: const [
          DateLable(lable: 'Yesterday'),
          FreindMessageBubble(
            message: 'Hi, Lucy! How\'s your day going?',
            messageDate: '12:01 PM',
          ),
          MessageBubble(
            message: 'You know how it goes...',
            messageDate: '12:02 PM',
          ),
          FreindMessageBubble(
            message: 'Do you want Starbucks?',
            messageDate: '12:02 PM',
          ),
          MessageBubble(
            message: 'Would be awesome!',
            messageDate: '12:03 PM',
          ),
          FreindMessageBubble(
            message: 'Coming up!',
            messageDate: '12:03 PM',
          ),
          MessageBubble(
            message: 'YAY!!!',
            messageDate: '12:03 PM',
          ),
        ],
      ),
    );
  }
}