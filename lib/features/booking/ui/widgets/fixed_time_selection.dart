import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../core/services/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/repos/appointment_repo.dart';
import '../../data/repos/availability_cubit.dart';

class TimeSelectionSection extends StatefulWidget {
  const TimeSelectionSection({super.key});

  @override
  State<TimeSelectionSection> createState() => _TimeSelectionSectionState();
}

class _TimeSelectionSectionState extends State<TimeSelectionSection> {
  int selectedDayIndex = 0;
  int? selectedSlotIndex;
  String? selectedReason;
  DateTime? selectedDate;
  String selectedTime = "";
  DateTime currentMonth = DateTime.now();

  final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final fullDays = [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  // Function to get a list of months for selection including December and months from next year
  List<DateTime> getMonths() {
    final now = DateTime.now();
    final List<DateTime> months = [];

    // Add current month and up to 12 future months (covers a full year)
    for (var i = 0; i < 13; i++) {
      final month = DateTime(now.year, now.month + i, 1);
      // Don't go beyond next year's December
      if (month.year <= now.year + 1) {
        months.add(month);
      }
    }

    // Always ensure December of current year is included
    final december = DateTime(now.year, 12, 1);
    if (!months.any((m) => m.month == 12 && m.year == now.year)) {
      months.add(december);
      // Sort to maintain chronological order
      months.sort((a, b) => a.compareTo(b));
    }

    return months;
  }

  // Show month picker dialog
  void _showMonthPicker() {
    final months = getMonths();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with title and close button
              Row(
                children: [
                  const Text(
                    "Select Month",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    color: Colors.grey[700],
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 8),

              // List of months with December highlighted
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final month = months[index];
                    final isSelected = month.month == currentMonth.month &&
                        month.year == currentMonth.year;

                    // Special highlight for December
                    final isDecember = month.month == 12;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          currentMonth = month;
                          selectedDayIndex = 0; // Reset day selection
                          selectedSlotIndex = null; // Reset time slot
                          selectedTime = ""; // Reset time
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xff1877F2).withValues(alpha:0.1)
                              : isDecember
                                  ? Colors.red.withValues(alpha:0.05)
                                  : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: isSelected
                              ? Border.all(
                                  color: const Color(0xff1877F2), width: 1.5)
                              : isDecember
                                  ? Border.all(
                                      color: Colors.red.withValues(alpha:0.5),
                                      width: 1)
                                  : null,
                        ),
                        child: Row(
                          children: [
                            // Add celebration icon for December
                            if (isDecember)
                              const Padding(
                                padding: EdgeInsets.only(right: 8),
                                child: Icon(
                                  Icons.celebration,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            Text(
                              DateFormat('MMMM yyyy').format(month),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected || isDecember
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? const Color(0xff1877F2)
                                    : isDecember
                                        ? Colors.red
                                        : Colors.black,
                              ),
                            ),
                            const Spacer(),
                            if (isSelected)
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Color(0xff1877F2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Rest of your existing methods and build function
  List<Map<String, String>> generateAvailableSlots(
    String startTime,
    String endTime,
    List<dynamic>? bookedSlots,
  ) {
    final format = DateFormat.Hm();
    final List<Map<String, String>> slots = [];

    DateTime start = format.parse(startTime);
    DateTime end = format.parse(endTime);

    while (start.isBefore(end)) {
      final next = start.add(const Duration(hours: 1));

      final slot = {
        'startTime': format.format(start),
        'endTime': format.format(next),
      };

      final isBooked = bookedSlots != null &&
          bookedSlots.any((b) =>
              b.startTime == slot['startTime'] && b.endTime == slot['endTime']);

      if (!isBooked && next.isBefore(end.add(const Duration(minutes: 1)))) {
        slots.add(slot);
      }

      start = next;
    }

    return slots;
  }

  @override
  Widget build(BuildContext context) {
    final DateTime currentDate = DateTime.now();
    final String currentMonthString =
        DateFormat('MMMM yyyy').format(currentMonth);
    final int daysInMonth =
        DateTime(currentMonth.year, currentMonth.month + 1, 0).day;

    return BlocProvider(
      create: (context) => AvailabilityCubit(
        appointmentRepo: AppointmentRepoImpl(apiServices: ApiServices(Dio())),
      )..getAvailabilityById('68117ae41e738c75a42879cc'),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Month selection with nice card
              GestureDetector(
                onTap: _showMonthPicker,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1877F2).withValues(alpha:0.1),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_rounded,
                        color: Color(0xff1877F2),
                        size: 28,
                      ),
                      const Gap(12),
                      Text(
                        currentMonthString,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1877F2),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: _showMonthPicker,
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Color(0xff1877F2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(24),

              // Horizontal scroll for days selection
              Row(
                children: [
                  const Text(
                    "Select a Day",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff1877F2).withValues(alpha:0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: const Row(
                      children: [
                        Icon(Icons.info_outline,
                            size: 16, color: Color(0xff1877F2)),
                        Gap(4),
                        Text(
                          "Swipe to view more",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(12),
              SizedBox(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isSelected = selectedDayIndex == index;
                    final dayDate =
                        DateTime(currentMonth.year, currentMonth.month, day);
                    final dayOfWeek =
                        dayDate.weekday - 1; // 0 = Monday, 6 = Sunday
                    final isToday = dayDate.day == currentDate.day &&
                        dayDate.month == currentDate.month &&
                        dayDate.year == currentDate.year;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            setState(() {
                              selectedDayIndex = index;
                              selectedDate = DateTime(
                                  currentMonth.year, currentMonth.month, day);
                              // Reset time selection when day changes
                              selectedSlotIndex = null;
                              selectedTime = "";
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 65,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xff1877F2)
                                  : isToday
                                      ? const Color(0xff1877F2).withValues(alpha:0.1)
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: isSelected
                                      ? const Color(0xff1877F2).withValues(alpha:0.3)
                                      : Colors.black.withValues(alpha:0.05),
                                  blurRadius: isSelected ? 8 : 2,
                                  spreadRadius: isSelected ? 1 : 0,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: isToday && !isSelected
                                  ? Border.all(
                                      color: const Color(0xff1877F2),
                                      width: 1.5)
                                  : null,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  days[dayOfWeek],
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : isToday
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                const Gap(6),
                                Text(
                                  '$day',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : isToday
                                            ? AppColors.primaryColor
                                            : Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Rest of your widget (available slots, etc.)
            ],
          ),
        ),
      ),
    );
  }
}
