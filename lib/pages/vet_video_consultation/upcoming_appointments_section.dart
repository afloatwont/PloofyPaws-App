import 'package:flutter/material.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  const UpcomingAppointmentsSection({super.key});
  final String date = 'Tues, 28 May 2024, 10:00 am IST';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Upcoming Appointments',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                )),
            TextButton(
              onPressed: () {
                // Handle view all action
              },
              child: const Text('View all'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade400,
            ),
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.blueGrey[50],
                        backgroundImage: const AssetImage(
                            'assets/images/services/cardimg.png'),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dr. Samira Sharma', style: TextStyle()),
                          Text('Veterinarian (Animal welfare)',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Text('4.8'),
                            ],
                          ),
                          SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    // width: double.maxFinite,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 0, 137, 249),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: IntrinsicWidth(
                      stepWidth: 2,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Image.asset(
                  "assets/images/content/doctor_and_dog.png",
                  fit: BoxFit.fitHeight,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
