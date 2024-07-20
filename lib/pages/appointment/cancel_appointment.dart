import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';

class CancelAppointment extends StatefulWidget {
  const CancelAppointment({super.key});

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  String? _selectedReason;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cancel Booking'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: _buildAppointmentCard(context),
            ),
            Container(
              color: const Color(0xffeF3F3F3),
              padding: const EdgeInsets.all(16),
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.08,
              alignment: Alignment.centerLeft,
              child: const Text(
                'Reason for Cancellation',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RadioListTile(
                    title:
                        const Text('A reason here for cancellation of booking'),
                    value: 'reason1',
                    groupValue: _selectedReason,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                        'A reason here for cancellation of booking, a reason here for cancellation of booking'),
                    value: 'reason2',
                    groupValue: _selectedReason,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title:
                        const Text('A reason here for cancellation of booking'),
                    value: 'reason3',
                    groupValue: _selectedReason,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value as String?;
                      });
                    },
                  ),
                  RadioListTile(
                    title: const Text(
                        'A reason here for cancellation of booking, a reason here for cancellation of booking, a reason here for cancellation of booking'),
                    value: 'reason4',
                    groupValue: _selectedReason,
                    activeColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value as String?;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Describe a problem / comment',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
              child: Center(
                child: ElevatedButton(
                  onPressed: _selectedReason == null
                      ? null
                      : () {
                          // Navigate to the BookingCancelled page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BookingCancelled()),
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor:
                        _selectedReason == null ? Colors.grey : Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Cancel"),
                ),
              ),
            ),
          ],
        ),
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
}

class BookingCancelled extends StatelessWidget {
  const BookingCancelled({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Cancelled'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.cancel_rounded,
                      color: Colors.red,
                      size: MediaQuery.sizeOf(context).height * 0.15,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Booking Cancelled!',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Dear John Kevin you have successfully cancelled your booking of Pet Grooming on date 12 Dec. We hope to serve you better :)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Previous',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '19th Nov, Saturday',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'AC service\n• General service',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle Share Feedback button press
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(
                                MediaQuery.sizeOf(context).width * 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Share Feedback'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle View details button press
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size.fromWidth(
                                MediaQuery.sizeOf(context).width * 0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('View details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Diamond Facial',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1 hr\nIncludes dummy info',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Go back'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
