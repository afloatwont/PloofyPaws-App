import 'dart:math';

enum PetType { cat, dog, bird, fish, hamster, turtle, other }

enum WeightUnit { kg, lbs, gms }

class Pet {
  final String? name;
  final String? ownerId;
  final String? description;
  final List<String>? characteristics;
  final String? aggression;
  final String? diet;
  final String? type;
  final String? breeds;
  final String? weight;
  final String? weightUnit;
  final DateTime? dob;
  final String? gender;
  final List<String> extraDetails;

  Pet({
    required this.name,
    this.description,
    required this.ownerId,
    this.characteristics,
    required this.weight,
    this.aggression,
    this.diet,
    required this.type,
    this.breeds,
    required this.weightUnit,
    required this.dob,
    required this.gender,
    required this.extraDetails,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      name: json['name'],
      ownerId: json['ownerId'],
      description: json['description'],
      characteristics:
          List<String>.from(json['characteristics'] ?? <String>[""]),
      aggression: json['aggression'],
      diet: json['diet'],
      type: json['type'],
      breeds: json['breeds'],
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
      'ownerId': ownerId,
      'characteristics': characteristics,
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

  double getWeightInKg() {
    if (weight == null) return 0;
    double mass = double.parse(weight!);
    switch (weightUnit!.toLowerCase()) {
      case 'kg':
        return mass;
      case 'lbs':
        return mass * 0.453592;
      case 'gms':
        return mass / 1000;
      default:
        return mass;
    }
  }

  int calculateDailyCalories() {
    double weightInKg = getWeightInKg();
    int ageInMonths = DateTime.now().difference(dob!).inDays ~/ 30;
    print(ageInMonths);
    switch (type?.toLowerCase()) {
      case 'dog':
        if (ageInMonths < 12) {
          return (70 * pow(weightInKg, 0.75) * 3).toInt(); // Puppy formula
        } else {
          return (70 * pow(weightInKg, 0.75)).toInt(); // Adult dog formula
        }
      case 'cat':
        return (100 * weightInKg).toInt(); // Basic cat formula
      default:
        throw Exception('Unsupported pet type for calorie calculation');
    }
  }

  int calculateNumberOfMeals() {
    int ageInMonths = DateTime.now().difference(dob!).inDays ~/ 30;

    switch (type?.toLowerCase()) {
      case 'dog':
        return ageInMonths < 12
            ? 3
            : 2; // Puppies: 3 meals, Adult dogs: 2 meals
      case 'cat':
        return 3; // Cats typically do well with multiple small meals
      default:
        throw Exception('Unsupported pet type for meal calculation');
    }
  }
}
