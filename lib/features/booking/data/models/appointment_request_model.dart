class AppointmentRequestModel {
  final String doctorId;
  final String date;
  final String time;
  final String reason;

  AppointmentRequestModel({
    required this.doctorId,
    required this.date,
    required this.time,
    required this.reason,
  });

  Map<String, dynamic> toJson() {
    return {
      'doctorId': doctorId,
      'date': date,
      'time': time,
      'reason': reason,
    };
  }
}
