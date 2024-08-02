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
import 'package:video_player/video_player.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final Map<String, String> properties = {
    "Balanced Diet": "assets/images/content/balanced_diet.png",
    "Weight management": "assets/images/content/weight_management.png",
    "Small paws diet": "assets/images/content/small_paws_diet.png",
    "Customised recipies": "assets/images/content/customised_recipies.png",
  };

  final List<Map<String, String>> features = const [
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

  final Map<String, String> whyPloofy = {
    "Expert Guidance": "assets/images/content/expert_guidance.png",
    "Health Benefits": "assets/images/content/health_benefits.png",
    "Dietary Insights": "assets/images/content/dietary_insights.png",
  };

  @override
  Widget build(BuildContext context) {
    final appBarHeight = MediaQuery.sizeOf(context).height * 0.41;
    final urlProvider = context.watch<UrlProvider>();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: urlProvider
                    .urlMap['assets/images/content/nutrition_bg.png']!,
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
                    gradient: const Color(0xfff5b96e),
                    textColor: const Color(0xffbc6a03),
                    image: 'assets/images/content/logo_yellow.png',
                    title: "Ploofy Nutrition",
                    subtitle: "your pets' health companions",
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
                            color: const Color(0xfff5b96e), features: features),
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
                        // buildIconRow2(context),
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
