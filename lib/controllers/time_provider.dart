import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeProvider with ChangeNotifier {
  String _time = '06:30 AM';

  String get time => _time;

  void setTime(String newTime) {
    _time = newTime;
    notifyListeners();
  }
}
