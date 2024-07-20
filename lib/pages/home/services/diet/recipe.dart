import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    return Scaffold(
      backgroundColor: const Color(0xffe2c2d30),
      body: Stack(
        children: [
          Column(
            children: [
              // Carousel Slider
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.44,
                  autoPlay: true,
                  aspectRatio: 4 / 3,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                ),
                items: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          urlProvider
                              .urlMap['assets/images/content/recipe.png']!,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Permanent Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Ginger & Garlic Noosle Soup',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Ginger Garlic Noosle Soup With Bok Choy is a nutritious, comforting, and flu-fighting twenty minute recipe made with vegetarian broth, Noosles, mushrooms, and baby bok choy.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 8.0),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'PREP TIME',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(8)),
                                Text(
                                  '5 minutes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'COOK TIME',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(8)),
                                Text(
                                  '15 minutes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'TOTAL TIME',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(8)),
                                Text(
                                  '20 minutes',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Divider(
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 16.0), // Adjust the left padding as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1 Tbsp olive oil',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '3 Shallots (diced)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '1 Bunch green onion (chopped, green & white divided)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '4 Cloves garlic (minced)',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Divider(
                        thickness: 1,
                        indent: 5,
                        endIndent: 5,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Recipe/Directions',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• Nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '• In reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 50),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
              top: MediaQuery.sizeOf(context).height * 0.04,
              left: MediaQuery.sizeOf(context).width * 0.02,
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ))),
          Positioned(
            left: MediaQuery.sizeOf(context).width * 0.02,
            right: MediaQuery.sizeOf(context).width * 0.02,
            bottom: MediaQuery.sizeOf(context).height * 0.02,
            child: Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(238, 255, 153, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  fixedSize: Size.fromWidth(MediaQuery.sizeOf(context).width),
                ),
                child: const Text(
                  'VIEW FULL LIST',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
