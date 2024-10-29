import 'package:flutter/material.dart';
import 'package:medify/chat/ui/views/all_chats.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';
import 'package:medify/helpers/tapProvider.dart';
import 'package:provider/provider.dart';

class BottomNavscreens extends StatelessWidget {
  const BottomNavscreens({super.key});

  @override
  Widget build(BuildContext context) {
    int currentindex = context.watch<tapProvider>().currentindex;
    // the widget returns page based on current index from tap provider
    return IndexedStack(
      index: currentindex,
      children: [
        wid(message: 'Home'),
        wid(message: 'Social'),
        wid(message: 'Doctors'),
        AllChats(),
        wid(message: 'HealthCare'),
      ],
    );
  }
}

class wid extends StatelessWidget {
  const wid({super.key, required this.message});
  final String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(message),
      ),
      bottomNavigationBar: bottomnavigationContent(),
    );
  }
}
