import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/features/availability_model.dart';
import '../../../core/helpers/show_custom_snack_bar.dart';
import '../../../core/utils/time_format_utils.dart';
import '../../booking/data/repos/availability_cubit.dart';
import '../../booking/data/repos/availability_state.dart';
import '../widgets/Dialog.dart';

class ScheduleTimingsPage extends StatefulWidget {
  const ScheduleTimingsPage({super.key});

  @override
  State<ScheduleTimingsPage> createState() => _ScheduleTimingsPageState();
}

class _ScheduleTimingsPageState extends State<ScheduleTimingsPage> {
  List<String> selectedDays = [];
  Map<String, TimeOfDay?> startTimes = {};
  Map<String, TimeOfDay?> endTimes = {};
  final List<String> days = [
    "SUNDAY",
    "MONDAY",
    "TUESDAY",
    "WEDNESDAY",
    "THURSDAY",
    "FRIDAY",
    "SATURDAY"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Schedule Timings",
          style: TextStyle(
            color: Color(0xff2260FF),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color(0xff2260FF),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
        child: BlocConsumer<AvailabilityCubit, AvailabilityState>(
          listener: (context, state) {
            if (state is AvailabilityError) {
              showCustomSnackBar(state.message, context, isError: true);
            } else if (state is AvailabilityUpdated) {
              showCustomSnackBar(state.message, context);
              context.read<AvailabilityCubit>().fetchAvailability();
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Timing Slot Duration",
                    style: TextStyle(fontSize: 16, color: Colors.blue[900])),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xff2260FF)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0xff2260FF), width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                  ),
                  value: "30 mins",
                  items: ["15 mins", "30 mins", "45 mins", "60 mins"]
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 45),
                Text(
                  "Schedule Timings",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900]),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 15,
                  runSpacing: 12,
                  children: days.map((day) {
                    return ChoiceChip(
                      label: Text(
                        day,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      selected: selectedDays.contains(day),
                      onSelected: (selected) {
                        setState(() {
                          if (selected) {
                            selectedDays.add(day);
                          } else {
                            selectedDays.remove(day);
                          }
                        });
                      },
                      backgroundColor: Colors.white,
                      selectedColor: Colors.blue[100],
                      shape: StadiumBorder(
                        side: BorderSide(color: Colors.blue.shade200),
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 50),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (selectedDays.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (_) => AddTimeSlotDialog(
                            selectedDay: selectedDays.join(', '),
                            onSave: (start, end) {
                              setState(() {
                                for (var day in selectedDays) {
                                  startTimes[day] = start;
                                  endTimes[day] = end;
                                }
                              });
                            },
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please select at least one day"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                    label: const Text("Add New Slot",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2260FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: const StadiumBorder(),
                      elevation: 2,
                      shadowColor: Colors.blueAccent.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.check, color: Colors.white),
                    onPressed: () {
                      if (selectedDays.isNotEmpty) {
                        List<Availability> availabilityList = selectedDays
                            .where((day) =>
                                startTimes[day] != null &&
                                endTimes[day] != null)
                            .map((day) {
                          return Availability(
                            dayOfWeek: day,
                            startTime: TimeFormatUtils.to12HourFormat(
                                startTimes[day]!.format(context)),
                            endTime: TimeFormatUtils.to12HourFormat(
                                endTimes[day]!.format(context)),
                          );
                        }).toList();

                        if (availabilityList.isEmpty) {
                          showCustomSnackBar(
                            "Please ensure each selected day has both start and end times set.",
                            context,
                            isError: true,
                          );
                        } else {
                          context
                              .read<AvailabilityCubit>()
                              .updateAvailability(availabilityList);
                        }
                      } else {
                        showCustomSnackBar(
                          "Please select at least one day",
                          context,
                          isError: true,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff2260FF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 14),
                      shape: const StadiumBorder(),
                      elevation: 2,
                      shadowColor: Colors.blueAccent.withValues(alpha: 0.4),
                    ),
                    label: const Text("Save",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 30),
                if (state is AvailabilityLoaded)
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.availability.length,
                      itemBuilder: (context, index) {
                        final availability = state.availability[index];
                        return Card(
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.blueAccent.withValues(alpha: 0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.blue[700],
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        availability.dayOfWeek,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.blue[800],
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'From: ${availability.startTime}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        'To: ${availability.endTime}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (state is AvailabilityLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff2260FF),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
