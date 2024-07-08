import 'dart:convert';

enum PetType { cat, dog, bird, fish, hamster, guneapig, turtle, horse, pig }

enum WeightUnit { kg, lbs, gms }

class Pet {
  final String? name;
  final String? description;
  final List<String>? characteristics;
  final String? size;
  final String? aggression;
  final String? diet;
  final String? type;
  final List<String>? breeds;
  final double? weight;
  final String? weightUnit;
  final DateTime? dob;
  final String? gender;
  final List<String> extraDetails;

  Pet({
    required this.name, // req
    this.description,
    this.characteristics,
    required this.size, //req
    this.aggression,
    this.diet,
    required this.type, //req
    this.breeds,
    this.weight,
    required this.weightUnit, //req
    required this.dob, // req
    required this.gender, //req
    required this.extraDetails, //req
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      description: json['description'],
      characteristics:
          List<String>.from(json['characteristics'] ?? <String>[""]),
      size: json['size'],
      aggression: json['aggression'],
      diet: json['diet'],
      type: json['type'],
      breeds: List<String>.from(json['breeds'] ?? <String>[""]),
      weight: json['weight'],
      weightUnit: json['weightUnit'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      extraDetails: List<String>.from(json['extraDetails'] ?? <String>[""]),
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
      'type': type,
      'breeds': breeds,
      'weight': weight,
      'weightUnit': weightUnit,
      'dob': dob!.toString(),
      'gender': gender,
      'extraDetails': extraDetails,
    };
  }
}
