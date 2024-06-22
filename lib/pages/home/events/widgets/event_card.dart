import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ploofypaws/components/button.dart';
import 'package:ploofypaws/config/theme/theme.dart';

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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(eventItem.imageAsset),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            height: 400,
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
                            style: typography(context)
                                .smallBody
                                .copyWith(color: colors(context).common.black?.s600, fontSize: 10),
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
                      Text(eventItem.price, style: typography(context).body.copyWith(fontWeight: FontWeight.bold)),
                      Button(
                        onPressed: () {},
                        variant: 'filled',
                        label: "Register",
                        buttonColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
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
