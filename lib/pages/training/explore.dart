import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/components/divider_with_text.dart';
import 'package:ploofypaws/components/feature_container.dart';
import 'package:ploofypaws/components/property_row.dart';
import 'package:ploofypaws/components/property_row_2.dart';
import 'package:ploofypaws/components/top_bar.dart';
import 'package:ploofypaws/components/video_box.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final List<Map<String, String>> features = [
    {
      'imagePath': 'assets/images/content/pt1.png',
      'title': "Breed-Specific Grooming",
      'description':
          "We provide specialized grooming techniques according to breed standards of your pets.",
    },
    {
      'imagePath': 'assets/images/content/pt2.png',
      'title': "Experienced Groomers",
      'description':
          "Our team consists of trained and certified groomers who understand your pet’s unique grooming needs and ensure a stress-free experience.",
    },
    {
      'imagePath': 'assets/images/content/pt3.png',
      'title': "Safety and Hygiene",
      'description':
          "We adhere to strict hygiene protocols and use high-quality, pet-safe products to ensure the safety and well-being of your pet during every grooming session.",
    },
  ];

  final Map<String, String> properties = {
    "Professional Grooming": "assets/images/content/professional_grooming.png",
    "Luxury Spa Treatments": "assets/images/content/luxury_spa_treatments.png",
    "Flexible Scheduling": "assets/images/content/flexible_scheduling.png",
    "At-Home Grooming": "assets/images/content/at_home_grooming.png",
  };

  final Map<String, String> whyPloofy = {
    'Affordable Packages': "assets/images/content/affordable_packages.png",
    'Pet-Friendly Products': "assets/images/content/pet_friendly_products.png",
    'Pet Pampering': "assets/images/content/pet_pampering.png",
  };

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.sizeOf(context).height * 0.41;
    final urlProvider = context.watch<UrlProvider>();
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: urlProvider
                    .urlMap['assets/images/content/grooming_bg.png']!,
                placeholder: null,
                errorWidget: null,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
                child: Container(
              color: const Color.fromARGB(191, 255, 255, 255),
            )),
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
                          "ADDITIONAL FEATURES",
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
