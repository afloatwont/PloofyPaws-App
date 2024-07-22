import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/divider_with_text.dart';
import 'package:ploofypaws/components/feature_container.dart';
import 'package:ploofypaws/components/property_row.dart';
import 'package:ploofypaws/components/property_row_2.dart';
import 'package:ploofypaws/components/top_bar.dart';
import 'package:ploofypaws/components/video_box.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, String>> features = [
    {
      'imagePath': 'assets/images/content/pt1.png',
      'title': "Weight Tracking:",
      'description':
          "Allows you to track your pet's weight over time to monitor progress and make adjustments to the diet plan as needed.",
    },
    {
      'imagePath': 'assets/images/content/pt2.png',
      'title': "Food Recommendations:",
      'description':
          "Provide a list of recommended pet foods or recipes tailored to the pet's nutritional needs.",
    },
    {
      'imagePath': 'assets/images/content/pt3.png',
      'title': "Reminders and Notifications:",
      'description':
          "You can set up a feeding schedule with reminders to ensure regular and timely meals.",
    },
  ];

  final Map<String, IconData> properties = {
    "Professional Expertise": Icons.pets,
    "Clean as before": Icons.cleaning_services,
    "Hygiene": Icons.local_hospital,
    "Authentic Products": Icons.restaurant,
  };

  final Map<String, Widget> whyPloofy = {
    'Affordable Packages': const Icon(Iconsax.money),
    'Pet-Friendly Products': const Icon(Iconsax.pet),
    'Pet Pampering': const Icon(Icons.spa_outlined),
  };

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.sizeOf(context).height * 0.41;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(
                    appBarHeight: appBarHeight,
                    gradient: const Color(0xff7d66c1),
                    textColor: const Color(0xff462c90),
                    image: 'assets/images/content/logo_grey.png',
                    title: "Ploofy Grooming",
                    subtitle: "your pets' grooming companion",
                  ),
                  buildDividerWithText(context, "For your companion!"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        PropertyRow(properties: properties),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 8),
                          child: Text(
                            "Why Ploofy Grooming?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        FeatureContainer(
                            color: const Color(0xff5A3CB0),
                            features: features,
                            textColor: Colors.white),
                        const SizedBox(height: 40), // Increased spacing
                        const VideoWidget(
                            url: 'assets/images/content/CREATE_YOUR.mp4'),
                        const SizedBox(height: 40), // Increased spacing
                        const Text(
                          "Why Ploofy Nutrition?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40), // Increased spacing
                        PropertyRow2(properties: whyPloofy),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * 0.02,
              left: MediaQuery.sizeOf(context).width * 0.08,
              right: MediaQuery.sizeOf(context).width * 0.08,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
