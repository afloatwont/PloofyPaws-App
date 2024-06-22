import 'package:flutter/material.dart';
import 'package:ploofypaws/controllers/calender_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalendarModalSheet extends ConsumerWidget {
  const CalendarModalSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final selectedDate = ref.watch(CalendarProvider.selectedDateProvider);
    final focusedDay = ref.watch(CalendarProvider.focusedDayProvider);

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
                ref.read(CalendarProvider.selectedDateProvider.notifier).state =
                    selectedDay;
                ref.read(CalendarProvider.focusedDayProvider.notifier).state =
                    focusedDay;
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
  }
}
