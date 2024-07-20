import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/appointment/appointment_details.dart';

class UpcomingAppointments extends StatefulWidget {
  const UpcomingAppointments({super.key});

  @override
  State<UpcomingAppointments> createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (context, index) {
        return _buildAppointmentCard(context);
      },
    );
  }

  Widget _buildAppointmentCard(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: mq.height * 0.25,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xffeF3F3F3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDate(DateTime.now()),
                Text(
                  "Grooming for pet",
                  style: typography(context).subtitle1,
                ),
              ],
            ),
            Expanded(
              child: _buildContent(["Hair Cut", "Shampoo"]),
            ),
            _buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
            child: const Text("Reschedule")),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AppointmentDetails()));
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width * 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.black,
            ),
            child: const Text("View Details")),
      ],
    );
  }

  Widget _buildContent(List<String> content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ListView.builder(
        itemCount: content.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 4,
              ),
              const SizedBox(width: 8),
              Text(content[index]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDate(DateTime date) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.sizeOf(context).width * 0.3,
      child: Column(children: [
        Text(
          formatDate(date),
          style: typography(context).title3,
        ),
      ]),
    );
  }

  String formatDate(DateTime date) {
    // Define the suffixes for day numbers
    String daySuffix(int day) {
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    // Format the date
    String day = date.day.toString();
    String month = DateFormat('MMM').format(date);
    String weekday = DateFormat('EEEE').format(date);

    return "$day${daySuffix(date.day)} $month, $weekday";
  }
}
