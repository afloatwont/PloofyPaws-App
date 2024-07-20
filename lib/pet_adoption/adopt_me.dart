import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class AdoptMePage extends StatefulWidget {
  const AdoptMePage({super.key});

  @override
  State<AdoptMePage> createState() => _AdoptMePageState();
}

class _AdoptMePageState extends State<AdoptMePage> {
  @override
  Widget build(BuildContext context) {
    final urlProvider = context.read<UrlProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.56,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: [
                  CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/adoptme.png']!,
                    placeholder: null,
                    errorWidget: null,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/adoptme.png']!,
                    placeholder: null,
                    errorWidget: null,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  CachedNetworkImage(
                    imageUrl: urlProvider
                        .urlMap['assets/images/content/adoptme.png']!,
                    placeholder: null,
                    errorWidget: null,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.5,
            minChildSize: 0.5,
            maxChildSize: 0.6,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Samantha',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Iconsax.location),
                                SizedBox(width: 6),
                                Text('Delhi, Rohini',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InfoCard(label: 'Male', value: 'Sex'),
                            InfoCard(label: 'Black', value: 'Color'),
                            InfoCard(label: 'Persian', value: 'Breed'),
                            InfoCard(label: '2kg', value: 'Weight'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              child: Icon(Icons.person_2_outlined),
                            ),
                            SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Owner by:',
                                    style: TextStyle(color: Colors.grey)),
                                Text('Pratibha Sharma',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.black,
                              child: Icon(Icons.call, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Lorem pellentesque velit donec congue. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            left: MediaQuery.sizeOf(context).width * 0.04,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.05,
            right: MediaQuery.sizeOf(context).width * 0.04,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.favorite, color: Colors.redAccent),
            ),
          ),
          Positioned(
            bottom: MediaQuery.sizeOf(context).height * 0.02,
            left: MediaQuery.sizeOf(context).width * 0.05,
            right: MediaQuery.sizeOf(context).width * 0.05,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Adopt Me',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String label;
  final String value;

  InfoCard({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: MediaQuery.sizeOf(context).height * 0.074,
      width: MediaQuery.sizeOf(context).width * 0.2,
      decoration: BoxDecoration(
        // color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
