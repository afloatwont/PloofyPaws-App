import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ploofypaws/controllers/calender_provider.dart';
import 'package:ploofypaws/controllers/time_provider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/package_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarModalSheet extends StatelessWidget {
  const CalendarModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final packageProvider = context.watch<PackageProvider>();
    final timeProvider = context.watch<TimeProvider>();
    return Consumer<CalendarProvider>(
      builder: (context, calendarProvider, child) {
        final selectedDate = calendarProvider.selectedDate;
        final focusedDay = calendarProvider.focusedDay;

        return Container(
          height: height * 0.6,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(selectedDate, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    calendarProvider.setSelectedDate(selectedDay);
                    calendarProvider.setFocusedDay(focusedDay);

                    DateTime combinedDateTime = getCombinedDateTime(
                      selectedDay,
                      getOriginalTime(timeProvider.time),
                    );
                    packageProvider.setTime(combinedDateTime);
                  },
                  calendarStyle: const CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: Colors.blue, // Customize the selected day color
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.red, // Customize the today color
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false, // Hide the format button
                    titleCentered: true, // Center the calendar title
                  ),
                ),
              ),

              // Expanded(
              //   flex: 1,
              //   child: Text(
              //     'Today Date: ${focusedDay.toLocal()}',
              //     style: const TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  DateTime getOriginalTime(String time) {
    final DateFormat formatter = DateFormat.jm();
    DateTime dateTime = formatter.parse(time);

    // Combine the parsed time with the current date
    return DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      dateTime.hour,
      dateTime.minute,
    );
  }

  // Method to combine the selected date with the original time
  DateTime getCombinedDateTime(DateTime selectedDate, DateTime originalTime) {
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      originalTime.hour,
      originalTime.minute,
    );
  }
}
