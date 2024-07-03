import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalendarProvider with ChangeNotifier {
  DateTime? _selectedDate;
  DateTime _focusedDay = DateTime.now();

  DateTime? get selectedDate => _selectedDate;
  DateTime get focusedDay => _focusedDay;

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setFocusedDay(DateTime date) {
    _focusedDay = date;
    notifyListeners();
  }
}
