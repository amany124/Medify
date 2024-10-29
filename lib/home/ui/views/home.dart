import 'package:flutter/material.dart';
import 'package:medify/bottom_nav/bottom_nav_screens.dart';
import 'package:medify/core/utils/widgets/bottom_navigation_content.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BottomNavscreens(),
    );
  }
}
