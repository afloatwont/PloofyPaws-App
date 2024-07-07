import 'dart:convert';

enum PetType { cat, dog, bird, fish, hamster, guneapig, turtle, horse, pig }
enum Gender { male, female, na }
enum WeightUnit { kg, lbs, gms }

class Pet {
  final String name;
  final String description;
  final List<String> characteristics;
  final double size;
  final String aggression;
  final String diet;
  final PetType type;
  final List<String> breeds;
  final double weight;
  final WeightUnit weightUnit;
  final DateTime dob;
  final Gender gender;
  final bool vaccinated;
  final bool neutered;
  final bool microchipped;
  final bool houseTrained;
  final bool leashTrained;

  Pet({
    required this.name,
    required this.description,
    required this.characteristics,
    required this.size,
    required this.aggression,
    required this.diet,
    required this.type,
    required this.breeds,
    required this.weight,
    required this.weightUnit,
    required this.dob,
    required this.gender,
    required this.vaccinated,
    required this.neutered,
    required this.microchipped,
    required this.houseTrained,
    required this.leashTrained,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      description: json['description'],
      characteristics: List<String>.from(json['characteristics']),
      size: json['size'],
      aggression: json['aggression'],
      diet: json['diet'],
      type: PetType.values.firstWhere((e) => e.toString() == 'PetType.${json['type']}'),
      breeds: List<String>.from(json['breeds']),
      weight: json['weight'],
      weightUnit: WeightUnit.values.firstWhere((e) => e.toString() == 'WeightUnit.${json['weightUnit']}'),
      dob: DateTime.parse(json['dob']),
      gender: Gender.values.firstWhere((e) => e.toString() == 'Gender.${json['gender']}'),
      vaccinated: json['vaccinated'],
      neutered: json['neutered'],
      microchipped: json['microchipped'],
      houseTrained: json['houseTrained'],
      leashTrained: json['leashTrained'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'characteristics': characteristics,
      'size': size,
      'aggression': aggression,
      'diet': diet,
      'type': type.toString().split('.').last,
      'breeds': breeds,
      'weight': weight,
      'weightUnit': weightUnit.toString().split('.').last,
      'dob': dob.toIso8601String(),
      'gender': gender.toString().split('.').last,
      'vaccinated': vaccinated,
      'neutered': neutered,
      'microchipped': microchipped,
      'houseTrained': houseTrained,
      'leashTrained': leashTrained,
    };
  }
}
