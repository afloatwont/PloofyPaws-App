import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DatePickerChannel {
  static const MethodChannel _channel = MethodChannel('date_picker');

  static Future<String?> pickDate() async {
    final String? date = await _channel.invokeMethod('pickDate');
    return date;
  }
}

class AdaptiveDatePicker {
  static Future<void> pickDate(
    BuildContext context, {
    required void Function(DateTime) onDateSelected,
    bool disableFutureDates = false,
    String? initialValue,
    DateTime? min,
    DateTime? max,
  }) async {
    final minimumSelectableDate = min ?? DateTime(DateTime.now().year - 100);
    final maximumSelectableDate = max ??
        (disableFutureDates ? DateTime.now().add(const Duration(seconds: 1)) : DateTime(DateTime.now().year + 100));

    DateTime? parsedInitialValue;

    if (initialValue != null && initialValue.isNotEmpty) {
      parsedInitialValue = DateTime.parse(initialValue);
    }

    if (Platform.isIOS) {
      await showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            height: 300.0,
            child: CupertinoDatePicker(
              initialDateTime: parsedInitialValue,
              mode: CupertinoDatePickerMode.date,
              minimumDate: minimumSelectableDate,
              maximumDate: maximumSelectableDate,
              onDateTimeChanged: onDateSelected,
            ),
          );
        },
      );
    } else {
      final value = await showDatePicker(
        context: context,
        initialDate: parsedInitialValue ?? DateTime.now(),
        firstDate: minimumSelectableDate,
        lastDate: maximumSelectableDate,
      );

      if (value != null) {
        onDateSelected(value);
      }
    }
  }
}
