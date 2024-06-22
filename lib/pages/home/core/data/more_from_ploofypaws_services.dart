import 'package:flutter/cupertino.dart';

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
