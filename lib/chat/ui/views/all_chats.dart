import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/chat/ui/widgets/chats_list.dart';
import 'package:medify/chat/ui/widgets/search_bar.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';

class AllChats extends StatelessWidget {
  const AllChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Icon(
          CupertinoIcons.back,
          color: Colors.black,
        ),
        centerTitle: true,
        title: Text(
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
      body: Column(
        children: [
          SearchBarWidget(),
          Expanded(child: ChatsList()),
        ],
      ),
      bottomNavigationBar: bottomnavigationContent(),
    );
  }
}

