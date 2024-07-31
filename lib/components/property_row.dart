import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class PropertyRow extends StatelessWidget {
  final Map<String, String> properties;

  const PropertyRow({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    final urlMap = context.read<UrlProvider>().urlMap;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: properties.entries.map((entry) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.22,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CachedNetworkImage(
                imageUrl: urlMap[entry.value]!,
                placeholder: null,
                errorWidget: null,
              ),
              Text(
                entry.key,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
