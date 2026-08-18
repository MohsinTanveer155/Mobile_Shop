import 'package:intl/intl.dart';

/// Utility class for date operations used in reports.
class DateUtilsHelper {
  DateUtilsHelper._();

  /// Returns true if two dates are the same calendar day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Returns the start of the day (00:00:00.000).
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Returns the end of the day (23:59:59.999).
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// Returns the start of the month.
  static DateTime startOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// Returns the end of the month.
  static DateTime endOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0, 23, 59, 59, 999);
  }

  /// Returns the start of the year.
  static DateTime startOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }

  /// Returns the end of the year.
  static DateTime endOfYear(DateTime date) {
    return DateTime(date.year, 12, 31, 23, 59, 59, 999);
  }

  /// Formats a date for report display.
  static String formatReportDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Formats a date with time.
  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy – hh:mm a').format(date);
  }

  /// Formats a date as short label (e.g. "12/25").
  static String formatShortDate(DateTime date) {
    return DateFormat('MM/dd').format(date);
  }

  /// Formats month as label (e.g. "Jan 2024").
  static String formatMonthLabel(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }
}

