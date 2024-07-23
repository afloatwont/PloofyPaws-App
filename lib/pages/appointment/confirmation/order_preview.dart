import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class OrderPreview extends StatelessWidget {
  const OrderPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.watch<UrlProvider>();
    return Container(
      // height: MediaQuery.sizeOf(context).height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Icon(Iconsax.hospital),
                ),
                Text(
                  "Dr. Samaira Sharma",
                  style: typography(context).strong,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Icon(Iconsax.link),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: urlProvider
                              .urlMap['assets/images/content/puppy.jpeg'] !=
                          null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(13),
                          child: CachedNetworkImage(
                            imageUrl: urlProvider
                                .urlMap['assets/images/content/puppy.jpeg']!,
                            fit: BoxFit.fitHeight,
                            placeholder: null,
                            errorWidget: null,
                            height: 50,
                            width: 50,
                          ),
                        )
                      : null,
                ),
                Text(
                  "Arlo",
                  style: typography(context).strong,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
