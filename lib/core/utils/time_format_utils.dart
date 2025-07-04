import 'package:intl/intl.dart';

/// Utility class for handling time format conversions and normalizations
class TimeFormatUtils {
  /// Normalizes any time string format to a standard 12-hour format (h:mm a)
  /// Handles both "8:00" and "8:00 AM" style inputs
  static String normalizeTimeFormat(String timeString) {
    // If the string already has AM/PM, check if it's properly formatted
    if (timeString.toLowerCase().contains('am') ||
        timeString.toLowerCase().contains('pm')) {
      // Try to standardize the format if needed
      try {
        final DateTime dateTime = parseTimeString(timeString);
        return DateFormat('h:mm a').format(dateTime);
      } catch (e) {
        // If parsing fails, return the original string
        return timeString;
      }
    }

    // If the string doesn't have AM/PM, add it
    try {
      // Parse the time string to a DateTime object
      final DateTime dateTime = parseTimeString(timeString);

      // Format to 12-hour time with AM/PM
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      // If parsing fails, return the original string
      print('Error normalizing time: $e for string: $timeString');
      return timeString;
    }
  }

  /// Ensures a time string is in 12-hour format with AM/PM
  static String to12HourFormat(String timeString) {
    // If already in 12-hour format, just return it
    if (_is12HourFormat(timeString)) {
      // Still try to standardize the format
      try {
        final DateTime dateTime = parseTimeString(timeString);
        return DateFormat('h:mm a').format(dateTime);
      } catch (e) {
        return timeString;
      }
    }

    try {
      // Parse the time string to a DateTime object
      final DateTime dateTime = parseTimeString(timeString);

      // Format to 12-hour time with AM/PM
      return DateFormat('h:mm a').format(dateTime);
    } catch (e) {
      // If parsing fails, return the original string
      print('Error converting to 12-hour format: $e for string: $timeString');
      return timeString;
    }
  }

  /// Parses a time string to DateTime
  /// This is public for use with other components
  static DateTime parseTimeString(String timeString) {
    if (timeString.isEmpty) {
      throw ArgumentError('Cannot parse empty time string');
    }

    // Clean up the time string - trim whitespace and standardize AM/PM format
    String cleanTime = timeString.trim();
    cleanTime = cleanTime.replaceAll(RegExp(r'\s+'), ' '); // normalize spaces

    // Standardize AM/PM notation
    cleanTime = cleanTime.replaceAll(RegExp(r'\.', caseSensitive: false),
        ''); // Remove periods from a.m./p.m.
    cleanTime =
        cleanTime.replaceAll(RegExp(r'a\s*m', caseSensitive: false), 'AM');
    cleanTime =
        cleanTime.replaceAll(RegExp(r'p\s*m', caseSensitive: false), 'PM');

    // Prepare a base date to which we'll add the time
    final now = DateTime.now();
    final baseDate = DateTime(now.year, now.month, now.day);

    // Try different parsing approaches
    try {
      // First try parsing as "h:mm a" (e.g., "8:00 AM")
      if (cleanTime.toUpperCase().contains('AM') ||
          cleanTime.toUpperCase().contains('PM')) {
        try {
          return DateFormat('h:mm a').parse(cleanTime);
        } catch (e) {
          // Try alternative AM/PM format
          try {
            return DateFormat('hh:mm a').parse(cleanTime);
          } catch (e2) {
            // Try handling more formats like "8AM" without space
            final regExp =
                RegExp(r'(\d{1,2}):?(\d{2})?\s*(AM|PM)', caseSensitive: false);
            final match = regExp.firstMatch(cleanTime);

            if (match != null) {
              int hour = int.parse(match.group(1)!);
              int minute = 0;
              if (match.group(2) != null) {
                minute = int.parse(match.group(2)!);
              }

              final isPM = match.group(3)!.toUpperCase() == 'PM';
              if (isPM && hour < 12) hour += 12;
              if (!isPM && hour == 12) hour = 0;

              return DateTime(
                  baseDate.year, baseDate.month, baseDate.day, hour, minute);
            }

            // Rethrow if we can't parse
            rethrow;
          }
        }
      }

      // Try parsing as 24-hour format "HH:mm" (e.g., "14:30")
      try {
        return DateFormat('HH:mm').parse(cleanTime);
      } catch (e) {
        // Try parsing as "H:mm" (e.g., "8:30")
        try {
          return DateFormat('H:mm').parse(cleanTime);
        } catch (e2) {
          // Continue to alternative formats
          rethrow;
        }
      }
    } catch (e) {
      // Try alternative formats
      try {
        // Try parsing as just hour and minute without AM/PM
        final parts = cleanTime.split(':');
        if (parts.isNotEmpty) {
          int hour = int.parse(parts[0].trim());
          int minute = 0;

          if (parts.length >= 2) {
            String minutePart = parts[1].replaceAll(RegExp(r'[^\d]'), '');
            minute = int.parse(minutePart);
          }

          // For times without AM/PM, we keep the 24-hour format as is
          // No need to convert since we're creating a DateTime

          // Create a datetime representing this time
          return DateTime(
              baseDate.year, baseDate.month, baseDate.day, hour, minute);
        }
      } catch (e2) {
        print('Alternative parsing failed: $e2 for string: $cleanTime');
      }

      // If all parsing attempts fail, rethrow the original error
      throw ArgumentError('Could not parse time string: $timeString');
    }
  }

  /// Checks if a time string is in 12-hour format with AM/PM
  static bool _is12HourFormat(String timeString) {
    // Simple check - if it has AM/PM, it's in 12-hour format
    final lowerCase = timeString.toLowerCase();
    return lowerCase.contains('am') || lowerCase.contains('pm');
  }

  /// Compares two time strings regardless of their format
  /// Returns true if they represent the same time
  static bool areTimesEqual(String time1, String time2) {
    // Parse both times to DateTime objects for accurate comparison
    try {
      final DateTime dateTime1 = parseTimeString(time1);
      final DateTime dateTime2 = parseTimeString(time2);

      // Compare hour and minute
      return dateTime1.hour == dateTime2.hour &&
          dateTime1.minute == dateTime2.minute;
    } catch (e) {
      // Fallback to string comparison if parsing fails
      final normalized1 = normalizeTimeFormat(time1);
      final normalized2 = normalizeTimeFormat(time2);
      return normalized1 == normalized2;
    }
  }

  /// Checks if one time is before another, regardless of format
  static bool isTimeBefore(String time1, String time2) {
    try {
      final DateTime dateTime1 = parseTimeString(time1);
      final DateTime dateTime2 = parseTimeString(time2);

      // Compare hours and minutes
      if (dateTime1.hour < dateTime2.hour) return true;
      if (dateTime1.hour > dateTime2.hour) return false;
      return dateTime1.minute < dateTime2.minute;
    } catch (e) {
      // Fallback to basic parsing
      print('Error comparing times: $e, using fallback');
      final DateTime dateTime1 = parseTimeString(normalizeTimeFormat(time1));
      final DateTime dateTime2 = parseTimeString(normalizeTimeFormat(time2));
      return dateTime1.isBefore(dateTime2);
    }
  }

  /// Checks if one time is after another, regardless of format
  static bool isTimeAfter(String time1, String time2) {
    try {
      final DateTime dateTime1 = parseTimeString(time1);
      final DateTime dateTime2 = parseTimeString(time2);

      // Compare hours and minutes
      if (dateTime1.hour > dateTime2.hour) return true;
      if (dateTime1.hour < dateTime2.hour) return false;
      return dateTime1.minute > dateTime2.minute;
    } catch (e) {
      // Fallback to basic parsing
      print('Error comparing times: $e, using fallback');
      final DateTime dateTime1 = parseTimeString(normalizeTimeFormat(time1));
      final DateTime dateTime2 = parseTimeString(normalizeTimeFormat(time2));
      return dateTime1.isAfter(dateTime2);
    }
  }

  /// Enhanced comparison that works with both formats
  /// Returns the 12-hour format string if both times are equal regardless of format
  static String getMatchingTime(String time1, String time2) {
    if (areTimesEqual(time1, time2)) {
      return to12HourFormat(time1);
    }
    return "";
  }

  /// Diagnostic method to help debug time format issues
  static Map<String, String> diagnoseTimeFormat(String timeString) {
    final result = <String, String>{
      'original': timeString,
      'normalized': 'Error',
      'hour24': 'Error',
      'parsed': 'Error',
      'valid': 'false'
    };

    try {
      // Try to normalize
      result['normalized'] = normalizeTimeFormat(timeString);

      // Try to parse
      final parsedTime = parseTimeString(timeString);
      result['parsed'] = parsedTime.toString();
      result['hour'] = parsedTime.hour.toString();
      result['minute'] = parsedTime.minute.toString();
      result['hour24'] =
          '${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}';
      result['valid'] = 'true';
    } catch (e) {
      result['error'] = e.toString();
    }

    return result;
  }
}
