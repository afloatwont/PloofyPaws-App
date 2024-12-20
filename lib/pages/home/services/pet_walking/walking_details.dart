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

class WalkingDetails extends StatefulWidget {
  const WalkingDetails({super.key});

  @override
  State<WalkingDetails> createState() => _WalkingDetailsState();
}

class _WalkingDetailsState extends State<WalkingDetails> {
  final List<Map<String, String>> features = [
  {
    'imagePath': 'assets/images/content/pt1.png',
    'title': "Real-time GPS Tracking",
    'description': "Stay connected with real-time tracking of your pet’s walks, ensuring peace of mind.",
  },
  {
    'imagePath': 'assets/images/content/pt2.png',
    'title': "Health Monitoring",
    'description': "Our walkers keep an eye on your pet’s physical activity and well-being, providing feedback and suggestions for maintaining optimal health.",
  },
  {
    'imagePath': 'assets/images/content/pt3.png',
    'title': "Safety Assurance",
    'description': "Our walkers are trained to handle various situations, ensuring your pet’s safety and security during every walk.",
  },
];


  final Map<String, String> properties = {
    "Fixed Walker": "assets/images/content/fixed_walker.png",
    "Daily Walks": "assets/images/content/daily_walks.png",
    "Custom Exercise Plans": "assets/images/content/custom_exercise_plans.png",
    "Flexible Time": "assets/images/content/flexible_time.png",
  };

  final Map<String, String> whyPloofy = {
    'Affordable rates': "assets/images/content/affordable_rates.png",
    'Personalised Attention': "assets/images/content/personalised_attention.png",
    'Experienced Walkers': "assets/images/content/experienced_walkers.png",
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
                    gradient: const Color(0xffE3C7B1),
                    textColor: const Color(0xff805736),
                    image: 'assets/images/content/logo_grey.png',
                    title: "Ploofy Walking",
                    subtitle: "your pets' walking companion",
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
                            "Why Ploofy Walking?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        FeatureContainer(
                            color: const Color(0xff805736),
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
