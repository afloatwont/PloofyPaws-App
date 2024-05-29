import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final Function(TimeOfDay) onTimeChanged;
  final TimeOfDay initialTime;

  const TimePicker({
    super.key,
    required this.onTimeChanged,
    required this.initialTime,
  });

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _time;

  @override
  void initState() {
    super.initState();
    _time = widget.initialTime;
  }

  Future<void> _showTimePicker(BuildContext context) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (selectedTime != null) {
      setState(() {
        _time = selectedTime;
      });
      widget.onTimeChanged(_time);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await _showTimePicker(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${_time.hour}:${_time.minute.toString().padLeft(2, '0')}',
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}
