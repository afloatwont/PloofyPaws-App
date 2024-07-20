import 'package:flutter/material.dart';
import 'package:ploofypaws/pages/appointment/previous_appointment.dart';
import 'package:ploofypaws/pages/appointment/upcoming_appointments.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Appointments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(48.0), // Set a height for the TabBar
            child: TabBar(
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
                insets: EdgeInsets.symmetric(horizontal: 100),
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(fontWeight: FontWeight.bold),
              tabs: [
                Tab(text: "Upcoming"),
                Tab(text: "Previous"),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            UpcomingAppointments(),
            PreviousAppointments(),
          ],
        ),
      ),
    );
  }
}
