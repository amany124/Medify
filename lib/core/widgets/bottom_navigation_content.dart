import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/core/helpers/local_data.dart';
import 'package:medify/core/helpers/tapProvider.dart';
import 'package:medify/features/authentication/register/data/models/auth_response_model.dart';
import 'package:medify/features/authentication/register/data/models/user_model.dart';
import 'package:medify/features/social/ui/cubits/get_posts_cubit/get_posts_cubit.dart';
import 'package:provider/provider.dart';

import '../../features/authentication/register/data/models/user_model.dart';
import '../../features/social/data/models/get_posts_request_model.dart';

class BottomnavigationContent extends StatelessWidget {
  const BottomnavigationContent({super.key});
  static Color primarycolor = const Color(0xff1677FF);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: context.watch<tapProvider>().currentindex,
      onTap: (index) {
        context.read<tapProvider>().updatecurrentindex(index);
        //  the code for getting posts for the selected index
      },

      selectedItemColor: primarycolor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 16,
        color: primarycolor,
      ),
      unselectedLabelStyle: const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      ),
      iconSize: 28,
      // type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          label: 'Home',
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Icon(
              Icons.home_outlined,
              size: 25,
              color: context.watch<tapProvider>().currentindex == 0
                  ? primarycolor // Selected color
                  : Colors.grey, // Unselected color
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Social',
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Icon(
              size: 25,
              Icons.badge_outlined,
              color: context.watch<tapProvider>().currentindex == 1
                  ? primarycolor
                  : Colors.grey,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Doctors',
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Icon(
              size: 25,
              CupertinoIcons.person_crop_square,
              color: context.watch<tapProvider>().currentindex == 2
                  ? primarycolor
                  : Colors.grey,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Chats',
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Icon(
              size: 25,
              CupertinoIcons.bolt_horizontal_circle,
              color: context.watch<tapProvider>().currentindex == 3
                  ? primarycolor
                  : Colors.grey,
            ),
          ),
        ),
        BottomNavigationBarItem(
          label: 'Notifications',
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Icon(
              size: 25,
              CupertinoIcons.bell,
              color: context.watch<tapProvider>().currentindex == 4
                  ? primarycolor
                  : Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
