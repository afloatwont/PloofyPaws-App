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

class TrainingDetails extends StatefulWidget {
  const TrainingDetails({super.key});

  @override
  State<TrainingDetails> createState() => _TrainingDetailsState();
}

class _TrainingDetailsState extends State<TrainingDetails> {
  final List<Map<String, String>> features = [
  {
    'imagePath': 'assets/images/content/pt1.png',
    'title': "Tailored Training Plans",
    'description': "Our expert trainers create customized training programs that address your pet’s specific behavior issues and learning pace, ensuring effective results.",
  },
  {
    'imagePath': 'assets/images/content/pt2.png',
    'title': "Progress Tracking",
    'description': "Detailed progress reports and regular updates, allowing you to monitor your pet’s improvement and adjust training strategies.",
  },
  {
    'imagePath': 'assets/images/content/pt3.png',
    'title': "Supportive Environment",
    'description': "Our training sessions are conducted in a positive environment, fostering a bond of trust and cooperation between you and your pet.",
  },
];


  final Map<String, String> properties = {
    "Behavorial Training": "assets/images/content/behavorial_training.png",
    "Obedience Training": "assets/images/content/obedience_training.png",
    "Personalised Sessions": "assets/images/content/personalised_sessions.png",
    "Experienced Trainers": "assets/images/content/experienced_trainers.png",
  };

  final Map<String, String> whyPloofy = {
    'Flexible Scheduling': "assets/images/content/flexible_scheduling2.png",
    'Interactive Sessions': "assets/images/content/interactive_sessions.png",
    'Continuous Support': "assets/images/content/continuous_support.png",
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
                    .urlMap['assets/images/content/training_bg.png']!,
                placeholder: null,
                errorWidget: null,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned.fill(
                child: Container(
              color: Color.fromARGB(191, 255, 255, 255),
            )),
            SingleChildScrollView(
              child: Column(
                children: [
                  TopBar(
                    appBarHeight: appBarHeight,
                    gradient: const Color(0xff587EBD),
                    textColor: const Color(0xff1B458B),
                    image: 'assets/images/content/logo_grey.png',
                    title: "Ploofy Training",
                    subtitle: "your pets' training companion",
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
                            color: const Color(0xff344BC3),
                            features: features,
                            textColor: Colors.white),
                        const SizedBox(height: 40), // Increased spacing
                        const VideoWidget(
                            url: 'assets/images/content/CREATE_YOUR.mp4'),
                        const SizedBox(height: 40), // Increased spacing
                        const Text(
                          "Why Ploofy Training?",
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
