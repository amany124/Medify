import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:medify/core/routing/extensions.dart';
=======
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
import 'package:medify/core/widgets/bottom_navigation_content.dart';
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
<<<<<<< HEAD
        leading: InkWell(
          
          onTap: () =>  context.pop(),
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
=======
        leading: const Icon(
          CupertinoIcons.back,
          color: Colors.black,
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
        ),
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
<<<<<<< HEAD
       
        
=======
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
>>>>>>> 89de72e36ba5e8003d07cad4b27408b6dbb22c03
      ),
      body: const Column(
        children: [
          SearchBarWidget(),
          Expanded(child: ChatsList()),
        ],
      ),
      bottomNavigationBar: const BottomnavigationContent(),
    );
  }
}
