import 'package:flutter/material.dart';

class TimeSlot extends StatelessWidget {
  final String time;
  final bool isSelected;

  const TimeSlot({super.key, required this.time, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        time,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}