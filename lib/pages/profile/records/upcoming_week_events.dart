import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restoe/components/tag.dart';
import 'package:restoe/config/theme/theme.dart';

class UpcomingDaysEvents extends StatefulWidget {
  const UpcomingDaysEvents({super.key});

  @override
  State<UpcomingDaysEvents> createState() => _UpcomingDaysEventsState();
}

class _UpcomingDaysEventsState extends State<UpcomingDaysEvents> {
  List<DateTime> getUpcomingWeekDates() {
    List<DateTime> upcomingDates = [];
    DateTime now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      upcomingDates.add(now.add(Duration(days: i)));
    }
    return upcomingDates;
  }

  @override
  Widget build(BuildContext context) {
    List<DateTime> upcomingDates = getUpcomingWeekDates();
    return Scaffold(
      body: ListView(
        children: [
          const Icon(Icons.minimize_rounded, size: 34),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Next 7 days \nfor arlo",
              style: typography(context).largeTitle,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              DateTime date = upcomingDates[index];
              bool today = isToday(date);
              return ListTile(
                title: Text(
                  DateFormat('EEEE, MMM d').format(date),
                  style: typography(context).strongSmallBody,
                ),
                subtitle: today
                    ? null
                    : Text("Nothing this day",
                        style: typography(context).smallBody.copyWith(
                              color: colors(context).onSurface.s400,
                            )),
                trailing: today
                    ? const Tag(
                        label: "Today",
                        color: "common.black",
                        size: "sm",
                      )
                    : null,
              );
            },
            separatorBuilder: (context, index) => const Divider(
              height: 1,
              color: Colors.grey,
            ),
            itemCount: upcomingDates.length,
          ),
        ],
      ),
    );
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }
}
