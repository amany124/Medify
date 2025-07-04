import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart'
    show AppointmentLoadingState, AppointmentState;

import '../../../../core/services/api_service.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/time_format_utils.dart';
import '../../data/models/appointment_request_model.dart';
import '../../data/repos/appointment_repo.dart';
import '../../data/repos/availability_cubit.dart';
import '../../data/repos/availability_state.dart';
import '../../presentation/cubit/patient_appointment_cubit.dart';

class TimeSelectionSection extends StatefulWidget {
  const TimeSelectionSection({super.key, required this.doctorId});
  final String doctorId;
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

  final days = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final fullDays = const [
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  List<DateTime> getMonths() {
    final now = DateTime.now();
    final List<DateTime> months = [];
    for (var i = 0; i < 13; i++) {
      final month = DateTime(now.year, now.month + i, 1);
      if (month.year <= now.year + 1) {
        months.add(month);
      }
    }
    final december = DateTime(now.year, 12, 1);
    if (!months.any((m) => m.month == 12 && m.year == now.year)) {
      months.add(december);
      months.sort((a, b) => a.compareTo(b));
    }
    return months;
  }

  void _showMonthPicker() {
    final months = getMonths();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MonthPickerHeader(onClose: () => Navigator.pop(context)),
              const Divider(),
              const SizedBox(height: 8),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: months.length,
                  itemBuilder: (context, index) {
                    final month = months[index];
                    final isSelected = month.month == currentMonth.month &&
                        month.year == currentMonth.year;
                    final isDecember = month.month == 12;
                    return _MonthPickerTile(
                      month: month,
                      isSelected: isSelected,
                      isDecember: isDecember,
                      onTap: () {
                        setState(() {
                          currentMonth = month;
                          selectedDayIndex = 0;
                          selectedSlotIndex = null;
                          selectedTime = "";
                        });
                        Navigator.pop(context);
                      },
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

  List<Map<String, String>> generateAvailableSlots(
    String startTime,
    String endTime,
    List<dynamic>? bookedSlots,
  ) {
    // Convert times to consistent 12-hour format
    final normalizedStartTime = TimeFormatUtils.to12HourFormat(startTime);
    final normalizedEndTime = TimeFormatUtils.to12HourFormat(endTime);

    final format = DateFormat('h:mm a');
    final List<Map<String, String>> slots = [];

    try {
      DateTime start = format.parse(normalizedStartTime);
      DateTime end = format.parse(normalizedEndTime);

      log('Generating slots from $normalizedStartTime to $normalizedEndTime');
      log('Parsed start: $start, end: $end');

      while (start.isBefore(end)) {
        final next = start.add(const Duration(hours: 1));
        final slotStartFormatted = format.format(start);
        final slotEndFormatted = format.format(next);

        final slot = {
          'startTime': slotStartFormatted,
          'endTime': slotEndFormatted,
        };

        // Check if the slot is booked, using enhanced time comparison
        final isBooked = bookedSlots != null &&
            bookedSlots.any((b) =>
                TimeFormatUtils.areTimesEqual(
                    b.startTime, slotStartFormatted) &&
                TimeFormatUtils.areTimesEqual(b.endTime, slotEndFormatted));

        if (!isBooked && next.isBefore(end.add(const Duration(minutes: 1)))) {
          log('Adding slot: ${slot['startTime']} - ${slot['endTime']}');
          slots.add(slot);
        } else if (isBooked) {
          log('Skipping booked slot: ${slot['startTime']} - ${slot['endTime']}');
        }

        start = next;
      }
    } catch (e) {
      log('Error generating slots: $e');
      // Fallback to simple hourly slots if parsing fails
      try {
        // Create a base date
        final baseDate = DateTime.now();

        // Parse using a simple approach (since we're in fallback mode)
        final startParts = startTime.split(':');
        final endParts = endTime.split(':');

        int startHour = int.parse(startParts[0].trim());
        int startMinute = 0;
        if (startParts.length > 1) {
          // Handle minutes and remove any AM/PM
          String minutePart =
              startParts[1].replaceAll(RegExp(r'[^\d]'), '').trim();
          startMinute = int.parse(minutePart);
        }

        int endHour = int.parse(endParts[0].trim());
        int endMinute = 0;
        if (endParts.length > 1) {
          // Handle minutes and remove any AM/PM
          String minutePart =
              endParts[1].replaceAll(RegExp(r'[^\d]'), '').trim();
          endMinute = int.parse(minutePart);
        }

        // Determine AM/PM
        bool isStartPM = startTime.toLowerCase().contains('pm');
        bool isEndPM = endTime.toLowerCase().contains('pm');

        // Adjust hours for PM if needed
        if (isStartPM && startHour < 12) startHour += 12;
        if (isEndPM && endHour < 12) endHour += 12;

        final startDateTime = DateTime(baseDate.year, baseDate.month,
            baseDate.day, startHour, startMinute);
        final endDateTime = DateTime(
            baseDate.year, baseDate.month, baseDate.day, endHour, endMinute);

        // Generate hourly slots from start to end
        DateTime current = startDateTime;

        while (current.isBefore(endDateTime)) {
          final next = current.add(const Duration(hours: 1));
          if (next.isAfter(endDateTime)) break;

          final slotStart = DateFormat('h:mm a').format(current);
          final slotEnd = DateFormat('h:mm a').format(next);

          final slot = {
            'startTime': slotStart,
            'endTime': slotEnd,
          };

          // Check if slot is booked
          final isBooked = bookedSlots != null &&
              bookedSlots.any((b) =>
                  TimeFormatUtils.areTimesEqual(b.startTime, slotStart) &&
                  TimeFormatUtils.areTimesEqual(b.endTime, slotEnd));

          if (!isBooked) {
            slots.add(slot);
          }

          current = next;
        }
      } catch (e) {
        log('Fallback slot generation failed: $e');
      }
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
      )..getAvailabilityById(widget.doctorId),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MonthSelector(
              currentMonthString: currentMonthString,
              onTap: _showMonthPicker,
            ),
            const Gap(24),
            _DaySelectorHeader(),
            const Gap(12),
            _DaySelector(
              daysInMonth: daysInMonth,
              days: days,
              currentMonth: currentMonth,
              currentDate: currentDate,
              selectedDayIndex: selectedDayIndex,
              onDaySelected: (index, date) {
                setState(() {
                  selectedDayIndex = index;
                  selectedDate = date;
                  selectedSlotIndex = null;
                  selectedTime = "";
                });
              },
            ),
            const Gap(28),
            _AvailableSlotsHeader(),
            const Gap(16),
            BlocBuilder<AvailabilityCubit, AvailabilityState>(
              builder: (context, state) {
                if (state is AvailabilityLoading) {
                  return const _LoadingIndicator();
                } else if (state is AvailabilityError) {
                  return _ErrorIndicator(message: state.message);
                } else if (state is AvailabilityLoaded) {
                  final dayDate = DateTime(currentMonth.year,
                      currentMonth.month, selectedDayIndex + 1);
                  final weekdayIndex = dayDate.weekday - 1;
                  final selectedDay = fullDays[weekdayIndex];

                  log('Selected day: $selectedDay, weekdayIndex: $weekdayIndex');

                  // Use normalized day-of-week comparison for more robust matching
                  final filtered = state.availability.where((slot) {
                    // Try exact match first
                    if (slot.dayOfWeek.toUpperCase() == selectedDay) {
                      return true;
                    }

                    // Try matching by weekday index as fallback
                    try {
                      // Map day names to indices (1-based for DateTime.weekday)
                      final dayMap = {
                        'MONDAY': 1,
                        'TUESDAY': 2,
                        'WEDNESDAY': 3,
                        'THURSDAY': 4,
                        'FRIDAY': 5,
                        'SATURDAY': 6,
                        'SUNDAY': 7
                      };

                      // Get the weekday index from the day name
                      final slotDayIndex = dayMap[slot.dayOfWeek.toUpperCase()];
                      final selectedDayIndex = dayDate.weekday;

                      log('Comparing slot day: ${slot.dayOfWeek}, slotDayIndex: $slotDayIndex, selectedDayIndex: $selectedDayIndex');
                      return slotDayIndex == selectedDayIndex;
                    } catch (e) {
                      log('Error comparing days: $e');
                      return false;
                    }
                  }).toList();

                  log('Selected day: $selectedDay, found ${filtered.length} matching slots');

                  // Debug print for slot.dayOfWeek
                  for (var slot in state.availability) {
                    log('Available slot day: ${slot.dayOfWeek}, normalized: ${slot.dayOfWeek.toUpperCase()}');
                  }
                  final List<Map<String, String>> allSlots = [];
                  for (var item in filtered) {
                    allSlots.addAll(generateAvailableSlots(
                      item.startTime,
                      item.endTime,
                      item.bookedSlots,
                    ));
                  }

                  if (allSlots.isEmpty) {
                    return const _NoSlotsIndicator();
                  }

                  return _SlotsWrap(
                    allSlots: allSlots,
                    selectedSlotIndex: selectedSlotIndex,
                    onSlotSelected: (index, slot) {
                      setState(() {
                        selectedSlotIndex = index;
                        selectedTime = slot['startTime'] ?? "";
                        log('Selected time: $selectedTime');
                        final day = selectedDayIndex + 1;

                        // Use the TimeFormatUtils to properly parse the time string with AM/PM
                        try {
                          // Parse the time correctly using our utility
                          final parsedTime =
                              TimeFormatUtils.parseTimeString(selectedTime);
                          log('Parsed time: $parsedTime, hour: ${parsedTime.hour}, minute: ${parsedTime.minute}');

                          selectedDate = DateTime(
                            currentMonth.year,
                            currentMonth.month,
                            day,
                            parsedTime.hour,
                            parsedTime.minute,
                          );
                        } catch (e) {
                          log('Error parsing time: $e');
                          // Fallback parsing for "h:mm a" format
                          try {
                            final timeParts = selectedTime.split(' ');
                            final timeComponent = timeParts[0].split(':');
                            final amPm = timeParts.length > 1
                                ? timeParts[1].toLowerCase()
                                : 'am';

                            int hour = int.parse(timeComponent[0]);
                            int minute = 0;

                            // Handle minutes if available
                            if (timeComponent.length > 1) {
                              minute = int.parse(timeComponent[1]);
                            }

                            // Adjust for PM
                            if (amPm == 'pm' && hour < 12) {
                              hour += 12;
                            } else if (amPm == 'am' && hour == 12) {
                              hour = 0;
                            }

                            selectedDate = DateTime(
                              currentMonth.year,
                              currentMonth.month,
                              day,
                              hour,
                              minute,
                            );
                            log('Fallback parsed time - hour: $hour, minute: $minute');
                          } catch (e) {
                            log('Fallback parsing also failed: $e');
                            // Last resort - just use current time
                            final now = DateTime.now();
                            selectedDate = DateTime(
                              currentMonth.year,
                              currentMonth.month,
                              day,
                              now.hour,
                              now.minute,
                            );
                          }
                        }
                      });
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const Gap(30),
            Builder(
              builder: (context) {
                final availabilityState =
                    context.watch<AvailabilityCubit>().state;
                if (availabilityState is AvailabilityLoaded) {
                  final dayDate = DateTime(currentMonth.year,
                      currentMonth.month, selectedDayIndex + 1);
                  final weekdayIndex = dayDate.weekday - 1;
                  final selectedDay = fullDays[weekdayIndex];

                  // Use normalized day-of-week comparison for more robust matching
                  final filtered = availabilityState.availability.where((slot) {
                    // Try exact match first
                    if (slot.dayOfWeek.toUpperCase() == selectedDay) {
                      return true;
                    }

                    // Try matching by weekday index as fallback
                    try {
                      // Map day names to indices (1-based for DateTime.weekday)
                      final dayMap = {
                        'MONDAY': 1,
                        'TUESDAY': 2,
                        'WEDNESDAY': 3,
                        'THURSDAY': 4,
                        'FRIDAY': 5,
                        'SATURDAY': 6,
                        'SUNDAY': 7
                      };

                      // Get the weekday index from the day name
                      final slotDayIndex = dayMap[slot.dayOfWeek.toUpperCase()];
                      final selectedDayIndex = dayDate.weekday;

                      return slotDayIndex == selectedDayIndex;
                    } catch (e) {
                      return false;
                    }
                  }).toList();

                  final List<Map<String, String>> allSlots = [];
                  for (var item in filtered) {
                    allSlots.addAll(generateAvailableSlots(
                      item.startTime,
                      item.endTime,
                      item.bookedSlots,
                    ));
                  }

                  if (allSlots.isEmpty) return const SizedBox.shrink();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AppointmentDetailsCard(
                        selectedSlotIndex: selectedSlotIndex,
                        selectedDate: selectedDate,
                        selectedTime: selectedTime,
                        selectedReason: selectedReason,
                        onReasonChanged: (value) {
                          setState(() {
                            selectedReason = value;
                          });
                        },
                      ),
                      const Gap(30),
                      _BookAppointmentButton(
                        selectedSlotIndex: selectedSlotIndex,
                        selectedReason: selectedReason,
                        selectedDate: selectedDate,
                        selectedTime: selectedTime,
                        doctorId: widget.doctorId,
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}

// --- UI Subcomponents ---

class _MonthPickerHeader extends StatelessWidget {
  final VoidCallback onClose;
  const _MonthPickerHeader({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Select Month",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        IconButton(
          onPressed: onClose,
          icon: const Icon(Icons.close),
          color: Colors.grey[700],
        ),
      ],
    );
  }
}

class _MonthPickerTile extends StatelessWidget {
  final DateTime month;
  final bool isSelected;
  final bool isDecember;
  final VoidCallback onTap;

  const _MonthPickerTile({
    required this.month,
    required this.isSelected,
    required this.isDecember,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xff1877F2).withAlpha((0.1 * 255).round())
              : isDecember
                  ? Colors.red.withAlpha((0.05 * 255).round())
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: const Color(0xff1877F2), width: 1.5)
              : isDecember
                  ? Border.all(
                      color: Colors.red.withAlpha((0.5 * 255).round()),
                      width: 1)
                  : null,
        ),
        child: Row(
          children: [
            if (isDecember)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(Icons.celebration, color: Colors.red, size: 20),
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
                child: const Icon(Icons.check, color: Colors.white, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}

class _MonthSelector extends StatelessWidget {
  final String currentMonthString;
  final VoidCallback onTap;

  const _MonthSelector({
    required this.currentMonthString,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1877F2).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.calendar_month_rounded,
                color: Color(0xff1877F2), size: 28),
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
              onPressed: onTap,
              icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                  color: Color(0xff1877F2)),
            ),
          ],
        ),
      ),
    );
  }
}

class _DaySelectorHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Select a Day",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xff1877F2).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: const Row(
            children: [
              Icon(Icons.info_outline, size: 16, color: Color(0xff1877F2)),
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
    );
  }
}

class _DaySelector extends StatelessWidget {
  final int daysInMonth;
  final List<String> days;
  final DateTime currentMonth;
  final DateTime currentDate;
  final int selectedDayIndex;
  final void Function(int, DateTime) onDaySelected;

  const _DaySelector({
    required this.daysInMonth,
    required this.days,
    required this.currentMonth,
    required this.currentDate,
    required this.selectedDayIndex,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: daysInMonth,
        itemBuilder: (context, index) {
          final day = index + 1;
          final isSelected = selectedDayIndex == index;
          final dayDate = DateTime(currentMonth.year, currentMonth.month, day);
          final dayOfWeek = dayDate.weekday - 1;
          final isToday = dayDate.day == currentDate.day &&
              dayDate.month == currentDate.month &&
              dayDate.year == currentDate.year;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => onDaySelected(index, dayDate),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 65,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xff1877F2)
                        : isToday
                            ? const Color(0xff1877F2).withValues(alpha: 0.1)
                            : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? const Color(0xff1877F2).withValues(alpha: 0.3)
                            : Colors.black.withValues(alpha: 0.05),
                        blurRadius: isSelected ? 8 : 2,
                        spreadRadius: isSelected ? 1 : 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    border: isToday && !isSelected
                        ? Border.all(color: const Color(0xff1877F2), width: 1.5)
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
    );
  }
}

class _AvailableSlotsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "Available Slots",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xff1877F2).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            children: [
              Icon(Icons.access_time_rounded,
                  size: 14, color: Color(0xff1877F2)),
              Gap(4),
              Text(
                "1 hour each",
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
    );
  }
}

class _SlotsWrap extends StatelessWidget {
  final List<Map<String, String>> allSlots;
  final int? selectedSlotIndex;
  final void Function(int, Map<String, String>) onSlotSelected;

  const _SlotsWrap({
    required this.allSlots,
    required this.selectedSlotIndex,
    required this.onSlotSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Wrap(
        spacing: 12,
        runSpacing: 16,
        children: allSlots.asMap().entries.map((entry) {
          int index = entry.key;
          var slot = entry.value;
          final bool isSelected = selectedSlotIndex == index;
          return GestureDetector(
            onTap: () => onSlotSelected(index, slot),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: MediaQuery.of(context).size.width / 2 - 24,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xff1877F2) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? const Color(0xff1877F2).withValues(alpha: 0.4)
                        : Colors.black.withValues(alpha: 0.05),
                    blurRadius: isSelected ? 10 : 4,
                    offset: Offset(0, isSelected ? 2 : 1),
                    spreadRadius: isSelected ? 1 : 0,
                  ),
                ],
                border:
                    !isSelected ? Border.all(color: Colors.grey[200]!) : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 16,
                    color: isSelected ? Colors.white : const Color(0xff1877F2),
                  ),
                  const Gap(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'From',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.8)
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          slot['startTime']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'To',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.8)
                                : Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          slot['endTime']!,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AppointmentDetailsCard extends StatelessWidget {
  final int? selectedSlotIndex;
  final DateTime? selectedDate;
  final String selectedTime;
  final String? selectedReason;
  final ValueChanged<String> onReasonChanged;

  const _AppointmentDetailsCard({
    required this.selectedSlotIndex,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedReason,
    required this.onReasonChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xff1877F2).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Appointment Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Gap(16),
          if (selectedSlotIndex != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1877F2).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                      color: Color(0xff1877F2),
                      size: 24,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Selected Date & Time",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        const Gap(4),
                        Text(
                          "${selectedDate != null ? DateFormat('EEEE, MMM d').format(selectedDate!) : ''} at $selectedTime",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          const Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Reason for Appointment",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              const Gap(8),
              Material(
                elevation: 0,
                shadowColor: Colors.black12,
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          selectedReason != null && selectedReason!.isNotEmpty
                              ? const Color(0xff1877F2)
                              : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: TextField(
                    onChanged: onReasonChanged,
                    maxLines: 3,
                    style: const TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      hintText: 'Describe your symptoms or reason...',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(left: 12, right: 8),
                        child: Icon(
                          Icons.description_outlined,
                          color: Color.fromARGB(255, 8, 98, 216),
                          size: 24,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BookAppointmentButton extends StatelessWidget {
  final int? selectedSlotIndex;
  final String? selectedReason;
  final DateTime? selectedDate;
  final String selectedTime;
  final String doctorId;

  const _BookAppointmentButton({
    required this.selectedSlotIndex,
    required this.selectedReason,
    required this.selectedDate,
    required this.selectedTime,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = selectedSlotIndex != null &&
        selectedReason != null &&
        selectedReason!.isNotEmpty;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isEnabled
          ? BlocBuilder<PatientAppointmentCubit, AppointmentState>(
              builder: (context, state) {
                final bool isLoading = state is AppointmentLoadingState;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      if (state is! AppointmentLoadingState) {
                        if (selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please select a day and time slot.'),
                            ),
                          );
                          return;
                        }
                        context
                            .read<PatientAppointmentCubit>()
                            .createAppointment(
                              appointmentRequestModel: AppointmentRequestModel(
                                date: DateFormat('yyyy-MM-dd')
                                    .format(selectedDate!),
                                time: selectedTime,
                                doctorId: doctorId,
                                reason: selectedReason!,
                              ),
                            );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: const Color(0xff1877F2),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.grey[300],
                      disabledForegroundColor: Colors.grey[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 8,
                      shadowColor:
                          const Color(0xff1877F2).withValues(alpha: 0.8),
                    ),
                    child: isLoading
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(12),
                              Text(
                                'Processing...',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.check_circle_outline,
                                  color: Colors.white),
                              Gap(8),
                              Text(
                                'Book Appointment',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                );
              },
            )
          : Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.grey[300],
                  disabledBackgroundColor: Colors.grey[300],
                  disabledForegroundColor: Colors.grey[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[600]),
                    const Gap(8),
                    Text(
                      'Select Time & Enter Reason',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CircularProgressIndicator(
          color: Color(0xff1877F2),
        ),
      ),
    );
  }
}

class _ErrorIndicator extends StatelessWidget {
  final String message;
  const _ErrorIndicator({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.error_outline, color: Colors.red[300], size: 40),
            const Gap(8),
            Text(
              message,
              style: TextStyle(
                color: Colors.red[300],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoSlotsIndicator extends StatelessWidget {
  const _NoSlotsIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        children: [
          Icon(Icons.event_busy, size: 50, color: Colors.grey[400]),
          const Gap(12),
          Text(
            "No available slots for this day",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const Gap(8),
          Text(
            "Please select another day",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
