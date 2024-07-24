import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class AddCoupon extends StatelessWidget {
  const AddCoupon({super.key});

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.watch<UrlProvider>();
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      // width: double.maxFinite,
      child: ListTile(
        tileColor: Colors.white,
        leading: urlProvider.urlMap['assets/images/content/offer.png'] != null
            ? CachedNetworkImage(
                imageUrl:
                    urlProvider.urlMap['assets/images/content/offer.png']!,
                placeholder: null,
                errorWidget: null,
              )
            : null,
        title: const Text("Add Coupon"),
        trailing: IconButton(
            onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
      ),
    );
  }
}
