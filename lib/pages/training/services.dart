import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the size for each item based on the available width
          double itemWidth = (constraints.maxWidth - 24.0) / 3;
          double itemHeight = itemWidth;

          return GridView.builder(
            shrinkWrap: true,
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(_titles[index], itemWidth, itemHeight);
            },
          );
        },
      ),
    );
  }

  // List of titles
  final List<String> _titles = [
    "Real-Time Tracking",
    "Paw Cleaning",
    "Poop Scooping",
    "Flexible Time",
    "Fixed Walker",
    "Pet Exercised",
  ];

  Widget _buildServiceItem(String title, double width, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height * 0.5,
          width: width * 0.5,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(title, textAlign: TextAlign.center),
      ],
    );
  }
}
