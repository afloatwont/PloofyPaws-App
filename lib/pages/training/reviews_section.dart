import 'package:flutter/material.dart';

class ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VVC reviews',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        ReviewCard(
          userName: 'Samaira Sharma',
          reviewDate: '26/03/2024',
          reviewText: 'Excellent support!',
        ),
        ReviewCard(
          userName: 'Samaira Sharma',
          reviewDate: '26/03/2024',
          reviewText: 'Excellent support!',
        ),
        ReviewCard(
          userName: 'Samaira Sharma',
          reviewDate: '26/03/2024',
          reviewText: 'Excellent support!',
        ),
        ReviewCard(
          userName: 'Samaira Sharma',
          reviewDate: '26/03/2024',
          reviewText: 'Excellent support!',
        ),
        ReviewCard(
          userName: 'Samaira Sharma',
          reviewDate: '26/03/2024',
          reviewText: 'Excellent support!',
        ),
      ],
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String userName;
  final String reviewDate;
  final String reviewText;

  const ReviewCard({super.key, 
    required this.userName,
    required this.reviewDate,
    required this.reviewText,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 210, 227, 234),
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green, width: 1),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(userName,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(width: 4),
                        Text(reviewDate,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(reviewText),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
