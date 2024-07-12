import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    final appbarheight = MediaQuery.sizeOf(context).height * 0.41;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: appbarheight),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.22,
                              child: const Column(
                                children: [
                                  Icon(Icons.pets),
                                  Text(
                                    "Professional Expertise",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.cleaning_services,
                                ),
                                SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    child: const Text(
                                      "Clean as before",
                                      textAlign: TextAlign.center,
                                    )),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    child: const Icon(Icons.local_hospital)),
                                const Text(
                                  "Hygiene",
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(Icons.restaurant),
                                SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.2,
                                    child: const Text(
                                      "Authentic Products",
                                      textAlign: TextAlign.center,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.all(
                              MediaQuery.sizeOf(context).width * 0.04),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(194, 64, 38, 137),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/content/pt1.png',
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.06),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Weight Tracking:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Allows you to track your pet's weight over time to monitor progress and make adjustments to the diet plan as needed.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.04),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/content/pt2.png',
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.06),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Food Recommendations:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Provide a list of recommended pet foods or recipes tailored to the pet's nutritional needs.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.04),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/content/pt3.png',
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                  ),
                                  SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.06),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Reminders and Notifications:",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "You can set up a feeding schedule with reminders to ensure regular and timely meals.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.24,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Text(
                              "video",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Why Ploofy Nutrition?",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.22,
                              child: const Column(
                                children: [
                                  Icon(Icons.check_circle, size: 50),
                                  Text(
                                    "Balanced Diet",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.22,
                              child: const Column(
                                children: [
                                  Icon(Icons.check_circle, size: 50),
                                  Text(
                                    "Weight Management",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.22,
                              child: const Column(
                                children: [
                                  Icon(Icons.check_circle, size: 50),
                                  Text(
                                    "Small Paws Diet",
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Stack(
                children: [
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * 0.05,
                      left: MediaQuery.sizeOf(context).width * 0.03,
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                          ))),
                  Container(
                    height: appbarheight * 0.98,
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffe7D66C1), Colors.white],
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
                        const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/content/logo.png"),
                        ),
                        const Text(
                          "Ploofy Grooming",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                            color: Color(0xffe462C90),
                          ),
                        ),
                        const Text(
                          "your pets' grooming companions",
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
                                  color: Color(0xffe462C90),
                                ),
                              ),
                              Text(
                                " for 3 months",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xffe462C90),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffe462C90),
                            foregroundColor: Colors.white,
                            fixedSize: Size(
                                MediaQuery.sizeOf(context).width * 0.6,
                                MediaQuery.sizeOf(context).height * 0.07),
                          ),
                          child: const Text("Buy Now"),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                bottom: MediaQuery.sizeOf(context).height * 0.1,
                left: MediaQuery.sizeOf(context).width * 0.1,
                right: MediaQuery.sizeOf(context).width * 0.1,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text("Buy Now"))),
          ],
        ),
      ),
    );
  }
}
