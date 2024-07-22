import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class FeatureContainer extends StatelessWidget {
  const FeatureContainer(
      {super.key,
      required this.color,
      required this.features,
      this.textColor = Colors.black});
  final Color color, textColor;

  final List<Map<String, String>> features;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: features.map((feature) {
          return Column(
            children: [
              buildFeatureContainer(
                context,
                feature['imagePath']!,
                feature['title']!,
                feature['description']!,
              ),
              SizedBox(height: MediaQuery.sizeOf(context).width * 0.04),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget buildFeatureContainer(BuildContext context, String imagePath,
      String title, String description) {
    final urlProvider = context.watch<UrlProvider>();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: urlProvider.urlMap[imagePath]!,
          placeholder: null,
          errorWidget: null,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(color: textColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
