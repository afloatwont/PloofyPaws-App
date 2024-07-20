import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/config/theme/placebo_colors.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class DoctorCard extends StatelessWidget {
  final String name;
  final double rating;
  final int reviews;
  final String specialty;
  final int experience;
  final String responseTime;

  DoctorCard({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.specialty,
    required this.experience,
    required this.responseTime,
  });

  @override
  Widget build(BuildContext context) {

     final urlProvider = context.read<UrlProvider>();
  final imageUrl = urlProvider.urlMap['assets/images/services/cardimg.png'];
    return Card(
      elevation: 5,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                  ClipOval(
                    child: imageUrl != null
                      ? CachedNetworkImage(
                          imageUrl: imageUrl,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        )
                      : const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: -3,
                    left: -9,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(10),
                      ),
                      child: const Text(
                        'Top rated',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 25),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.verified,
                        color: Colors.green,
                        size: 20,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius:
                            const BorderRadius.all(Radius.circular(6))),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 4),
                            Text(
                              rating.toString(),
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '$reviews reviews',
                        style:
                        const TextStyle(fontSize: 12, color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Veterinarian ($specialty)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    '$experience years of experience',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      'Avg. response time: $responseTime',
                      style: const TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}