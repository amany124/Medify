import 'package:flutter/material.dart';

class AddTimeSlotDialog extends StatefulWidget {
  final String selectedDay;
  final Function(TimeOfDay, TimeOfDay) onSave;

  const AddTimeSlotDialog({
    required this.selectedDay,
    required this.onSave,
    super.key,
  });

  @override
  State<AddTimeSlotDialog> createState() => _AddTimeSlotDialogState();
}

class _AddTimeSlotDialogState extends State<AddTimeSlotDialog> {
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  String formatTimeOfDay(TimeOfDay? time) {
    if (time == null) return "--:-- --";
    // Use standard format for consistency and convert if needed
    final formattedTime = time.format(context);
    return formattedTime;
  }

  Future<void> pickTime(bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff90CAF9),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            timePickerTheme: const TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteTextColor: Colors.black87,
              dialBackgroundColor: Color(0xffE3F2FD),
              dialHandColor: Color(0xff64B5F6),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text(
        "Add New Time Slot",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xff2260FF),
        ),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Start Time", style: TextStyle(color: Colors.blue[900])),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller:
                  TextEditingController(text: formatTimeOfDay(startTime)),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.access_time, color: Color(0xff2260FF)),
                hintText: "--:-- --",
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff2260FF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff2260FF), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () => pickTime(true),
            ),
            const SizedBox(height: 20),
            Text("End Time", style: TextStyle(color: Colors.blue[900])),
            const SizedBox(height: 8),
            TextField(
              readOnly: true,
              controller: TextEditingController(text: formatTimeOfDay(endTime)),
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(Icons.access_time, color: Color(0xff2260FF)),
                hintText: "--:-- --",
                hintStyle: TextStyle(color: Colors.grey[500]),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff2260FF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xff2260FF), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onTap: () => pickTime(false),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xff2260FF),
            backgroundColor: Colors.blue[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (startTime != null && endTime != null) {
              widget.onSave(startTime!, endTime!);
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff2260FF),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text("Save", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
