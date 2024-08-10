import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/pages/home/services/pet_diet.dart';
import 'package:ploofypaws/pages/home/services/pet_walking/pet_walking.dart';
import 'package:ploofypaws/pages/training/grooming.dart';
import 'package:ploofypaws/pages/training/training.dart';
import 'package:ploofypaws/pages/vet_video_consultation/vet_video_consultation.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';

class OtherServices extends StatefulWidget {
  const OtherServices({
    super.key,
    required this.titles,
    required this.otherimages,
  });

  final List<String> titles;
  final List<String> otherimages;

  @override
  State<OtherServices> createState() => _OtherServicesState();
}

class _OtherServicesState extends State<OtherServices> {
  final Map<String, Widget> _titleToScreenMap = {
    'Pet Walking': PetWalkingScreen(),
    'Pet Grooming': GroomingScreen(),
    'Ploofy-Diet': DietPage(),
    'Behaviourist': TrainingScreen(),
    'Vet Video Call': VetVideoConsultationScreen(),
    // Add other mappings here
  };

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
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.titles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0, // Adjust spacing as needed
              mainAxisSpacing: 8.0, // Adjust spacing as needed
              childAspectRatio: itemWidth / itemHeight,
            ),
            itemBuilder: (context, index) {
              return _buildServiceItem(
                widget.titles[index],
                itemWidth,
                itemHeight,
                widget.otherimages[index],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildServiceItem(
    String title,
    double width,
    double height,
    String image,
  ) {
    return Container(
      height: height * 0.6,
      width: width * 0.8,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
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
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      _titleToScreenMap[title] ??
                      const Scaffold(
                        body: Center(
                          child: Text('Screen not found'),
                        ),
                      ),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              fixedSize: Size(width * 0.8, height * 0.2),
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
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
