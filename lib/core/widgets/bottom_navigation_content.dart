import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medify/core/helpers/tapProvider.dart';
import 'package:provider/provider.dart';

class BottomnavigationContent extends StatelessWidget {
  const BottomnavigationContent({super.key});
  static Color primarycolor = const Color(0xff1877F2);

  // Helper method to build active icon with animation and background
  Widget _buildActiveIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primarycolor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: primarycolor.withValues(alpha: 0.05),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 24,
        color: primarycolor,
      ),
    );
  }

  // Helper method to build regular icon with subtle animation
  Widget _buildIcon(IconData icon, int index, BuildContext context) {
    final bool isSelected = context.watch<TapProvider>().currentindex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: Icon(
        icon,
        size: isSelected ? 24 : 22,
        color: isSelected ? primarycolor : Colors.grey.shade500,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<TapProvider>().currentindex;
    final width = MediaQuery.of(context).size.width;
    final tabWidth = width / 5; // 5 items in the navigation bar

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        // Bottom navigation bar
        DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 15,
                spreadRadius: 0,
                offset: const Offset(0, -4),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: currentIndex,
              onTap: (index) {
                context.read<TapProvider>().updatecurrentindex(index);
              },
              selectedItemColor: primarycolor,
              unselectedItemColor: Colors.grey.shade500,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              selectedLabelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primarycolor,
                letterSpacing: 0.2,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11,
                color: Colors.grey,
              ),
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  label: 'Home',
                  activeIcon: _buildActiveIcon(CupertinoIcons.house_fill),
                  icon: _buildIcon(CupertinoIcons.home, 0, context),
                ),
                BottomNavigationBarItem(
                  label: 'Social',
                  activeIcon: _buildActiveIcon(CupertinoIcons.person_2_fill),
                  icon: _buildIcon(CupertinoIcons.person_2, 1, context),
                ),
                BottomNavigationBarItem(
                  label: 'Doctors',
                  activeIcon:
                      _buildActiveIcon(CupertinoIcons.person_badge_plus_fill),
                  icon:
                      _buildIcon(CupertinoIcons.person_badge_plus, 2, context),
                ),
                BottomNavigationBarItem(
                  label: 'Chats',
                  activeIcon:
                      _buildActiveIcon(CupertinoIcons.chat_bubble_2_fill),
                  icon: _buildIcon(CupertinoIcons.chat_bubble_2, 3, context),
                ),
                BottomNavigationBarItem(
                  label: 'Notifications',
                  activeIcon: _buildActiveIcon(CupertinoIcons.bell_fill),
                  icon: _buildIcon(CupertinoIcons.bell, 4, context),
                ),
              ],
            ),
          ),
        ),

        // Active tab indicator
        Positioned(
          top: 0,
          left: (currentIndex * tabWidth) + (tabWidth - 30) / 2,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: 30,
            height: 3,
            decoration: BoxDecoration(
              color: primarycolor,
              borderRadius: BorderRadius.circular(1.5),
              boxShadow: [
                BoxShadow(
                  color: primarycolor.withValues(alpha: 0.3),
                  blurRadius: 3,
                  spreadRadius: 0,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
