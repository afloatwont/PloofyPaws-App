import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_assets.dart';
import 'package:provider/provider.dart';

class PetEventItem {
  final String imageAsset;
  final String title;
  final String dateTime;
  final String location;
  final String price;
  final String? typeOfEvent;

  PetEventItem({
    required this.imageAsset,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.price,
    this.typeOfEvent,
  });
}

class PetEventsCard extends StatelessWidget {
  final PetEventItem eventItem;

  const PetEventsCard({
    super.key,
    required this.eventItem,
  });

  @override
  Widget build(BuildContext context) {
    final urlProvider = context.watch<UrlProvider>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              // image: DecorationImage(
              //   image: CachedNetworkImageProvider(
              //     urlProvider.urlMap[eventItem.imageAsset]!,
              //   ),
              // ),
            ),
            height: 400,
            child: CachedNetworkImage(
              imageUrl: urlProvider.urlMap[eventItem.imageAsset]!,
              // Use the URL directly
              fit: BoxFit.cover,
              placeholder: null,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: const Offset(0, 0),
                ),
              ],
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              eventItem.title,
                              style: typography(context).body.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                          Chip(label: Text(eventItem.typeOfEvent ?? ""))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(Iconsax.calendar_1, size: 15),
                          const SizedBox(width: 8), // adjust as needed
                          Text(
                            eventItem.dateTime,
                            style: typography(context).smallBody.copyWith(
                                color: colors(context).common.black?.s600,
                                fontSize: 10),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8), // adjust as needed
                      Row(
                        children: [
                          const Icon(Iconsax.location, size: 15),
                          const SizedBox(width: 8), // adjust as needed
                          Text(
                            eventItem.location,
                            style: typography(context).smallBody.copyWith(
                                  color: colors(context).common.black?.s600,
                                  fontSize: 10,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(eventItem.price,
                          style: typography(context)
                              .body
                              .copyWith(fontWeight: FontWeight.bold)),
                      Button(
                        onPressed: () {},
                        variant: 'filled',
                        label: "Register",
                        buttonColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
