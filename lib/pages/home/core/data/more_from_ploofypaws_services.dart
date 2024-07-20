import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/components/dot_indicator.dart' as components;
import 'package:ploofypaws/pages/home/core/data/more_from_ploofypaws_services.dart';

// Define the MoreServices class
class MoreServices {
  final int id;
  final String? title;
  final String? description;
  final String? image;
  final Widget? topTrailing;

  MoreServices({
    required this.id,
    this.title,
    this.description,
    this.image,
    this.topTrailing,
  });
}

// Create the list of MoreServices
final List<MoreServices> moreServices = [
  MoreServices(
    id: 1,
    title: "Adopt \nDon't Shop",
    description: "Adopt a pet with ease",
    image: "assets/images/placeholders/ai_pets_card.png",
  ),
  MoreServices(
    id: 2,
    title: "Report \nLost Pet",
    description: "Report your missing pet",
    image: "assets/images/placeholders/ai_pets_card.png",
  ),
  MoreServices(
    id: 3,
    title: "Report \nLost Pet",
    description: "Report your missing pet",
    image: "assets/images/placeholders/ai_pets_card.png",
  ),
  MoreServices(
    id: 3,
    title: "Report \nLost Pet",
    description: "Report your missing pet",
    image: "assets/images/placeholders/ai_pets_card.png",
  ),
];

class MoreFromPloofyPaws extends StatefulWidget {
  @override
  _MoreFromPloofyPawsState createState() => _MoreFromPloofyPawsState();
}

class _MoreFromPloofyPawsState extends State<MoreFromPloofyPaws> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              itemCount: moreServices.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final data = moreServices[index];
                return Card(
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: data.image ?? 'assets/images/default.png',
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Text(data.title ?? 'No title'),
                      Text(data.description ?? 'No description'),
                    ],
                  ),
                );
              },
            ),
          ),
          components.AnimatedDotIndicator(
            count: moreServices.length,
            currentIndex: _currentPageIndex,
          ),
        ],
      ),
    );
  }
}
