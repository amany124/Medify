import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/features/chat/models/messageModel.dart';
import 'package:medify/features/chat/ui/widgets/AppBarTitle.dart';
import 'package:medify/features/chat/ui/widgets/ChatTextField.dart';
import 'package:medify/features/chat/ui/widgets/RenderMessages.dart';
import 'package:medify/features/chat/ui/widgets/icon_buttons.dart';

class MessagesPage extends StatelessWidget {
  static Route route(messageModel data) => MaterialPageRoute(
        builder: (context) => MessagesPage(
          messageData: data,
        ),
      );

  const MessagesPage({
    super.key,
    required this.messageData,
  });

  final messageModel messageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: const Column(
        children: [
          Expanded(
            child: RenderMessages(),
          ),
          ChatTextField(),
        ],
      ),
    );
  }
}
