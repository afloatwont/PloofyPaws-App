import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/pages/appointment/cancel_appointment.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AppointmentDetails extends StatefulWidget {
  const AppointmentDetails({super.key});

  @override
  State<AppointmentDetails> createState() => _AppointmentDetailsState();
}

class _AppointmentDetailsState extends State<AppointmentDetails> {
  late UserProvider userProvider;

  @override
  void initState() {
    super.initState();
    userProvider = context.read<UserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upcoming Appointment",
          style: typography(context).title2,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                width: mq.width * 0.3,
                child: Text(
                  formatDate(DateTime.now()),
                  style: typography(context).title3,
                ),
              ),
              _buildAppointmentCard(context),
              _buildAppointmentCard(context),
              _buildPaymentInfoCard(),
              _buildButtons(),
              _buildAddress(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.sizeOf(context).width * 0.425),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Reschedule")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CancelAppointment(),
                ));
              },
              style: ElevatedButton.styleFrom(
                fixedSize:
                    Size.fromWidth(MediaQuery.sizeOf(context).width * 0.425),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
              ),
              child: const Text("Cancel")),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: mq.height * 0.22,
        width: mq.width,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffeF3F3F3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Iconsax.home),
                const SizedBox(width: 12),
                _buildHeader(userProvider.user!.address?.saveAs ?? ""),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                  userProvider.user!.address?.getAddress().toUpperCase() ?? ""),
            ),
            Row(
              children: [
                const Icon(Icons.timer_outlined),
                const SizedBox(width: 12),
                Text(formatDateTime(DateTime.now())),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentInfoCard() {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        height: mq.height * 0.36,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffeF3F3F3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: _buildHeader("Billing Details"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildPrice(699, 50, 30),
            ),
            const Spacer(), // This will push the _buildPayment widget to the bottom
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: _buildPayment("Paytm UPI"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrice(int total, int discount, int service) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Item Total"),
                Text("₹$total"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Item Discount"),
                Text(
                  "-₹$discount",
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Service Fee"),
                Text("₹$service"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader("Grand Total"),
                _buildHeader("₹${total - discount + service}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayment(String method) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
          color: Color(0xffef3f3f3),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Payment Method"),
          Text(
            method,
            style: typography(context).strong,
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        height: mq.height * 0.16,
        width: mq.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffeF3F3F3), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: mq.width * 0.3,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader("Grooming"),
                  _buildContent(["2 hrs", "includes lorem ipsum"]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Text(
      title,
      style: typography(context).title3,
    );
  }

  Widget _buildContent(List<String> content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
        height: content.length *
            24.0, // Assuming each row height is approximately 24.0
        child: ListView.builder(
          itemCount: content.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
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
      ),
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

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('EEE, MMM dd - hh:mm a');
    return formatter.format(dateTime);
  }
}
