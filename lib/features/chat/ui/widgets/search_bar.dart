import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffF3F4F8), // Grey color with opacity
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none, // No border
            prefixIcon: Padding(
              padding: EdgeInsets.only(right: 15, left: 30),
              child: Icon(
                FeatherIcons.search,
                color: Color(0xffB5B6BA), // Search icon color
              ),
            ),
            hintText: 'Search message',
            hintStyle: TextStyle(color: Color(0xffB5B6BA)), // Hint text color
            contentPadding: EdgeInsets.symmetric(
                vertical: 17), // Padding for the text field
          ),
        ),
      ),
    );
  }
}
