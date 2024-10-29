import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/helpers/tapProvider.dart';
import 'package:provider/provider.dart';

class bottomnavigationContent extends StatelessWidget {
  bottomnavigationContent({super.key});
  Color primarycolor = const  Color(0xff1677FF);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: context.watch<tapProvider>().currentindex,
      onTap: (index) {
        context.read<tapProvider>().updatecurrentindex(index);
      },
      selectedItemColor:  primarycolor,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        fontSize: 16,
        color: primarycolor,
      ),
      unselectedLabelStyle: TextStyle(
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
