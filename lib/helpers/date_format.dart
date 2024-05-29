

import 'package:intl/intl.dart';

extension DateTimeExtensions on DateTime {
  // Example: January 20, 2020
  String toFullDate() {
    return DateFormat('MMMM d, yyyy').format(this);
  }

  // Example: Jan 20, 2020
  String toMediumDate() {
    return DateFormat('MMM d, yyyy').format(this);
  }

  // Example: 01/20/2020
  String toNumericDate() {
    return DateFormat('MM/dd/yyyy').format(this);
  }

  // Example: 20/01/2020
  String toEuropeanDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  // Example: Monday, January 20
  String toDayMonthDate() {
    return DateFormat('EEEE, MMMM d').format(this);
  }

  // Example: 20 Jan 2020
  String toDayMonthYearShort() {
    return DateFormat('d MMM yyyy').format(this);
  }

  // Example: Mon, Jan 20
  String toShortDayMonth() {
    return DateFormat('EEE, MMM d').format(this);
  }

  // Example: 2020-01-20
  String toIso8601() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  // Example: 20 January
  String toDayMonth() {
    return DateFormat('d MMMM').format(this);
  }

  // Example: 20 Jan
  String toShortMonthDay() {
    return DateFormat('d MMM').format(this);
  }

  // Example: 12:00 AM/PM
  String to12HourTime() {
    return DateFormat('hh:mm a').format(this);
  }

  // Example: 23:00 (24-hour format)
  String to24HourTime() {
    return DateFormat('HH:mm').format(this);
  }
}
