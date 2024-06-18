import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class CalendarProvider {
 
  static final selectedDateProvider = StateProvider<DateTime?>((ref) {
    return null; 
  });

  static final focusedDayProvider = StateProvider<DateTime>((ref) {
    return DateTime.now();
  });
}