import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class UpcomingAppointmentsSection extends StatelessWidget {
  const UpcomingAppointmentsSection({super.key});
  final String date = 'Tues, 28 May 2024, 10:00 am IST';

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
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
        // const SizedBox(height: 8),
        Stack(
          children: [
            Positioned(
                top: 0,
                right: -MediaQuery.sizeOf(context).width * 0.1,
                bottom: 0,
                child: CachedNetworkImage(
                  imageUrl: urlProvider
                      .urlMap['assets/images/content/Ellipse_253.png']!,
                  placeholder: null,
                  errorWidget: null,
                  fit: BoxFit.cover,
                )),
            Positioned(
                top: 0,
                left: MediaQuery.sizeOf(context).width * 0.45,
                child: CachedNetworkImage(
                  imageUrl: urlProvider
                      .urlMap['assets/images/content/Ellipse_254.png']!,
                  placeholder: null,
                  errorWidget: null,
                )),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blueGrey[50],
                              backgroundImage: CachedNetworkImageProvider(
                                  urlProvider.urlMap[
                                      'assets/images/services/cardimg.png']!)),
                          const SizedBox(width: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dr. Samira Sharma',
                                  style: typography(context).strongSmallBody),
                              const Text('Veterinarian (Animal welfare)',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                              const Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.yellow, size: 16),
                                  Text('4.8'),
                                ],
                              ),
                              const SizedBox(height: 4),
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
                      child: CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap["assets/images/content/doctor_and_dog.png"]!,
                    placeholder: null,
                    errorWidget: null,
                    height: 70,
                    fit: BoxFit.fitHeight,
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
