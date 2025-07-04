import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:medify/features/booking/presentation/cubit/appointment_state.dart'
    show AppointmentLoadingState, AppointmentState;

import '../../../../core/services/api_service.dart';
import '../../../authentication/login/ui/widgets/custom_filled_button.dart';
import '../../data/models/appointment_request_model.dart';
import '../../data/repos/appointment_repo.dart';
import '../../data/repos/availability_cubit.dart';
import '../../data/repos/availability_state.dart';
import '../../presentation/cubit/patient_appointment_cubit.dart';

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
    final String currentMonth = DateFormat('MMMM yyyy').format(currentDate);
    final int daysInMonth =
        DateTime(currentDate.year, currentDate.month + 1, 0).day;

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
              Row(
                children: [
                  Text(
                    currentMonth,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
              const Gap(20),

              // Horizontal scroll for days selection
              const Text(
                "Select a Day",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: daysInMonth,
                  itemBuilder: (context, index) {
                    final day = index + 1;
                    final isSelected = selectedDayIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                          selectedDate = DateTime(
                              currentDate.year, currentDate.month, day);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            splashColor: Colors.blue.withOpacity(0.3),
                            onTap: () {
                              setState(() {
                                selectedDayIndex = index;
                              });
                            },
                            child: Container(
                              width: 50,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:
                                    isSelected ? Colors.blue : Colors.grey[200],
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    days[index %
                                        7], // Use modulo for repeating days
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Gap(4),
                                  Text(
                                    '$day',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Gap(25),

              // Available Slots section
              const Text(
                "Available Slots",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Gap(8),
              BlocBuilder<AvailabilityCubit, AvailabilityState>(
                builder: (context, state) {
                  if (state is AvailabilityLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AvailabilityError) {
                    return Center(child: Text(state.message));
                  } else if (state is AvailabilityLoaded) {
                    final selectedDay =
                        fullDays[selectedDayIndex % fullDays.length];
                    final filtered = state.availability.where((slot) {
                      return slot.dayOfWeek == selectedDay;
                    }).toList();

                    final List<Map<String, String>> allSlots = [];

                    for (var item in filtered) {
                      allSlots.addAll(generateAvailableSlots(
                        item.startTime,
                        item.endTime,
                        item.bookedSlots,
                      ));
                    }

                    if (allSlots.isEmpty) {
                      return const Center(child: Text("No available slots"));
                    }

                    return Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: allSlots.asMap().entries.map((entry) {
                        int index = entry.key;
                        var slot = entry.value;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSlotIndex = index;
                              selectedTime = slot['startTime'] ?? "";
                              log(selectedTime);
                              selectedDate = DateTime(
                                selectedDate!.year,
                                selectedDate!.month,
                                selectedDate!.day,
                                int.parse(slot['startTime']!.split(':')[0]),
                                int.parse(slot['startTime']!.split(':')[1]),
                              );
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: selectedSlotIndex == index
                                  ? Colors.blue
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              '${slot['startTime']} - ${slot['endTime']}',
                              style: TextStyle(
                                color: selectedSlotIndex == index
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Gap(25),

              // Reason TextField and Book appointment button
              BlocBuilder<AvailabilityCubit, AvailabilityState>(
                builder: (context, state) {
                  if (state is AvailabilityLoaded) {
                    final selectedDay =
                        fullDays[selectedDayIndex % fullDays.length];
                    final filtered = state.availability.where((slot) {
                      return slot.dayOfWeek == selectedDay;
                    }).toList();

                    final List<Map<String, String>> allSlots = [];

                    for (var item in filtered) {
                      allSlots.addAll(generateAvailableSlots(
                        item.startTime,
                        item.endTime,
                        item.bookedSlots,
                      ));
                    }

                    if (allSlots.isEmpty) {
                      return const SizedBox
                          .shrink(); // Hide the TextFields if no slots available
                    }

                    return Column(
                      children: [
                        const Text(
                          "Reason for the Appointment",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              selectedReason = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter reason for appointment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const Gap(25),

                        // Book appointment button
                        selectedSlotIndex != null &&
                                selectedReason != null &&
                                selectedReason!.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(40),
                                child: BlocBuilder<PatientAppointmentCubit,
                                    AppointmentState>(
                                  builder: (context, state) {
                                    return CustomFilledButton(
                                      isLoading:
                                          state is AppointmentLoadingState,
                                      text: 'Book an Appointment',
                                      onPressed: () {
                                        if (state is! AppointmentLoadingState) {
                                          context
                                              .read<PatientAppointmentCubit>()
                                              .createAppointment(
                                                appointmentRequestModel:
                                                    AppointmentRequestModel(
                                                  date: DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate!),
                                                  time:
                                                      selectedTime, // Dynamically selected time
                                                  doctorId:
                                                      "68117ae41e738c75a42879cc",
                                                  reason:
                                                      selectedReason!, // Use the reason entered
                                                ),
                                              );
                                        }
                                      },
                                    );
                                  },
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
