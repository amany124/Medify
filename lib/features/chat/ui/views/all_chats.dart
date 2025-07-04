import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/features/chat/ui/widgets/chats_list.dart';
import 'package:medify/features/chat/ui/widgets/search_bar.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Open the drawer
                },
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          SearchBarWidget(),
          Expanded(child: ChatsList()),
        ],
      ),
    );
  }
}
