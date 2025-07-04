class Availability {
  final String dayOfWeek;
  final String startTime;
  final String endTime;
  final String? id;
  final List<dynamic>? bookedSlots;

  Availability({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    this.id,
    this.bookedSlots,
  });

  factory Availability.fromJson(Map<String, dynamic> json) {
    return Availability(
      dayOfWeek: json['dayOfWeek'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      id: json['_id'],
      bookedSlots:
          json['bookedSlots'].map((slot) => BookedSlot.fromJson(slot)).toList() ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayOfWeek': dayOfWeek,
      'startTime': startTime,
      'endTime': endTime,
      '_id': id,
      'bookedSlots': bookedSlots?.map((slot) => slot.toJson()).toList(),
    };
  }
}

class BookedSlot {
  final String startTime;
  final String endTime;
  final String appointmentId;
  final String id;

  BookedSlot({
    required this.startTime,
    required this.endTime,
    required this.appointmentId,
    required this.id,
  });

  factory BookedSlot.fromJson(Map<String, dynamic> json) {
    return BookedSlot(
      startTime: json['startTime'],
      endTime: json['endTime'],
      appointmentId: json['appointmentId'],
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'appointmentId': appointmentId,
      '_id': id,
    };
  }
}
