import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class PetProvider with ChangeNotifier {
  final List<Pet?> _pets = [];
  Pet? _currentPet;

  List<Pet?> get pets => _pets;
  Pet? get currentPet => _currentPet;

  void startAddingPet() {
    _currentPet = Pet(
      name: '',
      type: PetType.dog, // default value
      breeds: [],
      size: '',
      weight: 0,
      weightUnit: WeightUnit.kg, // default value
      dob: DateTime.now(),
      gender: Gender.idk, // default value
      vaccinated: false,
      neutered: false,
      microchipped: false,
      houseTrained: false,
      leashTrained: false,
    );
    notifyListeners();
  }

  void updatePet({
    String? name,
    PetType? type,
    List<String>? breeds,
    String? size,
    double? weight,
    WeightUnit? weightUnit,
    DateTime? dob,
    Gender? gender,
    bool? vaccinated,
    bool? neutered,
    bool? microchipped,
    bool? houseTrained,
    bool? leashTrained,
  }) {
    if (_currentPet != null) {
      _currentPet = Pet(
        name: name ?? _currentPet!.name,
        type: type ?? _currentPet!.type,
        breeds: breeds ?? _currentPet!.breeds,
        size: size ?? _currentPet!.size,
        weight: weight ?? _currentPet!.weight,
        weightUnit: weightUnit ?? _currentPet!.weightUnit,
        dob: dob ?? _currentPet!.dob,
        gender: gender ?? _currentPet!.gender,
        vaccinated: vaccinated ?? _currentPet!.vaccinated,
        neutered: neutered ?? _currentPet!.neutered,
        microchipped: microchipped ?? _currentPet!.microchipped,
        houseTrained: houseTrained ?? _currentPet!.houseTrained,
        leashTrained: leashTrained ?? _currentPet!.leashTrained,
      );
      notifyListeners();
    }
  }

  void finalizeAddingPet() {
    if (_currentPet != null) {
      _pets.add(_currentPet!);
      _currentPet = null;
      notifyListeners();
    }
  }
}
