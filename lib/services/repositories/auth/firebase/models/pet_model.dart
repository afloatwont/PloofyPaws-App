import 'dart:convert';

enum PetType { cat, dog, bird, fish, hamster, guneapig, turtle, horse, pig }
enum Gender { male, female, idk }
enum WeightUnit { kg, lbs, gms }

class Pet {
  final String name;
  final PetType type;
  final List<String> breeds;
  final String size;
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
    required this.type,
    required this.breeds,
    required this.size,
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
      type: PetType.values.firstWhere((e) => e.toString() == 'PetType.${json['type']}'),
      breeds: List<String>.from(json['breeds']),
      size: json['size'],
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
      'type': type.toString().split('.').last,
      'breeds': breeds,
      'size': size,
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
