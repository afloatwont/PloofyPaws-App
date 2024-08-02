import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class AddCoupon extends StatelessWidget {
  const AddCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.watch<UrlProvider>();

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Row(
        children: [
          if (urlProvider.urlMap['assets/images/content/offer.png'] != null)
            CachedNetworkImage(
              imageUrl: urlProvider.urlMap['assets/images/content/offer.png']!,
              placeholder: null,
              errorWidget: null,
              width: 40, // Specify the desired width
              height: 40, // Specify the desired height
            ),
          const SizedBox(width: 16), // Spacing between image and text
          const Expanded(
            child: Text(
              "Add Coupon",
              style: TextStyle(
                fontSize: 16.0, // Specify desired font size
                fontWeight: FontWeight.w500, // Specify desired font weight
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
