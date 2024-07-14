
import 'package:flutter/material.dart';

class OtherServices extends StatelessWidget {
  OtherServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate the size for each item based on the available width
          double itemWidth = (constraints.maxWidth - 24.0) / 2;
          double itemHeight = itemWidth * 0.6; // Adjust height as needed

          return GridView.builder(
            shrinkWrap: true,
            itemCount: 4,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0, // Adjust spacing as needed
              mainAxisSpacing: 8.0, // Adjust spacing as needed
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
    "Pet Grooming",
    "Ploofy-Diet",
    "Behaviourist",
    "Vet Video Call",
  ];

  Widget _buildServiceItem(String title, double width, double height) {
    return Container(
      height: height * 0.6,
      width: width * 0.8,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/content/memories_bg.png'), // Add your image path
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
          ),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              fixedSize: Size(width * 0.8, height * 0.2),
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
            child: const Text(
              'Explore services',
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}