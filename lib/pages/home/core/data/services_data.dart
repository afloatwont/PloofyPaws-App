import 'package:flutter/material.dart';
import 'package:ploofypaws/config/icons/pet_services/pet_services.dart';

class PetService {
  final int id;
  final String title;
  final Widget? image;

  PetService({
    required this.id,
    required this.title,
    required this.image,
  });
}

final List<PetService> petServices = [
  PetService(
      id: 1,
      title: "Walking",
      image: const PetWalking(
        height: 60,
      )),
  PetService(
      id: 2,
      title: "Grooming",
      image: const PetGrooming(
        height: 60,
      )),
  PetService(
      id: 3,
      title: "Vet",
      image: const PetVet(
        height: 60,
      )),
  PetService(
      id: 4,
      title: "Diet",
      image: const PetDiet(
        height: 60,
      )),
  PetService(
      id: 5,
      title: "Tracker",
      image: const PetTracker(
        height: 60,
      )),
  PetService(
    id: 6,
    title: "Behavior",
    image: const PetBehaviourist(
      height: 60,
    ),
  ),
];

final List<String> popularEvents = [
  'assets/images/placeholders/pet_event_placeholder.png',
  'assets/images/placeholders/pet_card_placeholder.png',
];
