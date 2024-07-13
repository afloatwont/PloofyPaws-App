import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        VideoPlayerController.asset('assets/images/content/CREATE_YOUR.mp4')
          ..initialize().then((_) {
            _controller.setLooping(true);
            _controller.play();
          });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: buildAppBar(context, appBarHeight),
                  ),
                  buildDividerWithText(context, "For your companion!"),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        buildIconRow(context),
                        const Padding(
                          padding: EdgeInsets.only(top: 16.0, bottom: 8),
                          child: Text(
                            "Why Ploofy Grooming?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        buildFeatureContainerGroup(context),
                        const SizedBox(height: 40), // Increased spacing
                        buildVideo(),
                        const SizedBox(height: 40), // Increased spacing
                        const Text(
                          "Why Ploofy Nutrition?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 40), // Increased spacing
                        buildIconRow2(context),
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

  Widget buildAppBar(BuildContext context, double appBarHeight) {
    return Stack(
      children: [
        Container(
          height: appBarHeight * 0.98,
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffef5b96e), Colors.white],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 35,
                  backgroundImage:
                      AssetImage("assets/images/content/logo_yellow.png"),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "Ploofy Nutrition",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xffebc6a03),
                  ),
                ),
              ),
              const Text(
                "your pets' health companions",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "RS. 399/-",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xffebc6a03),
                      ),
                    ),
                    Text(
                      " for 3 months",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xffebc6a03),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffebc6a03),
                  foregroundColor: Colors.white,
                  fixedSize: Size(
                    MediaQuery.sizeOf(context).width * 0.6,
                    MediaQuery.sizeOf(context).height * 0.07,
                  ),
                ),
                child: const Text("Buy Now"),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.05,
          left: MediaQuery.sizeOf(context).width * 0.03,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDividerWithText(BuildContext context, String text) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            indent: MediaQuery.sizeOf(context).width * 0.03,
            endIndent: MediaQuery.sizeOf(context).width * 0.03,
            thickness: 1,
            color: Colors.black,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: Divider(
            indent: MediaQuery.sizeOf(context).width * 0.03,
            endIndent: MediaQuery.sizeOf(context).width * 0.03,
            thickness: 1,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget buildIconRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.pets),
              Text(
                "Balanced Diet",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.breakfast_dining_rounded),
              Text(
                "Weight management",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.restaurant_outlined),
              Text(
                "Small paws diet",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.dashboard_customize_outlined),
              Text(
                "Customised products",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildIconRow2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.pets),
              Text(
                "Balanced Diet",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.breakfast_dining_rounded),
              Text(
                "Weight management",
                // textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.22,
          child: const Column(
            children: [
              Icon(Icons.restaurant_outlined),
              Text(
                "Small paws diet",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFeatureContainerGroup(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xffeFFB860),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          buildFeatureContainer(
            context,
            'assets/images/content/pt1.png',
            "Weight Tracking:",
            "Allows you to track your pet's weight over time to monitor progress and make adjustments to the diet plan as needed.",
          ),
          SizedBox(height: MediaQuery.sizeOf(context).width * 0.04),
          buildFeatureContainer(
            context,
            'assets/images/content/pt2.png',
            "Food Recommendations:",
            "Provide a list of recommended pet foods or recipes tailored to the pet's nutritional needs.",
          ),
          SizedBox(height: MediaQuery.sizeOf(context).width * 0.04),
          buildFeatureContainer(
            context,
            'assets/images/content/pt3.png',
            "Reminders and Notifications:",
            "You can set up a feeding schedule with reminders to ensure regular and timely meals.",
          ),
        ],
      ),
    );
  }

  Widget buildFeatureContainer(BuildContext context, String imagePath,
      String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          height: MediaQuery.sizeOf(context).width * 0.1,
          width: MediaQuery.sizeOf(context).width * 0.1,
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.06),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildVideo() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.24,
      color: Colors.grey.shade300,
      child: FutureBuilder(
        future: _controller.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
