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
      description: '',
      characteristics: [],
      size: "Not Specified",
      aggression: '',
      diet: '',
      type: "dog", // default value
      breeds: '',
      weight: 0,
      weightUnit: "Kg", // default value
      dob: DateTime.now(),
      gender: 'Not Specified', // default value
      extraDetails: [],
    );
    notifyListeners();
  }

  void updatePet({
    String? name,
    String? description,
    List<String>? characteristics,
    String? size,
    String? aggression,
    String? diet,
    String? type,
    String? breeds,
    double? weight,
    String? weightUnit,
    DateTime? dob,
    String? gender,
    List<String>? extraDetails,
  }) {
    if (_currentPet != null) {
      _currentPet = Pet(
        name: name ?? _currentPet!.name,
        description: description ?? _currentPet!.description,
        characteristics: characteristics ?? _currentPet!.characteristics,
        size: size ?? _currentPet!.size,
        aggression: aggression ?? _currentPet!.aggression,
        diet: diet ?? _currentPet!.diet,
        type: type ?? _currentPet!.type,
        breeds: breeds ?? _currentPet!.breeds,
        weight: weight ?? _currentPet!.weight,
        weightUnit: weightUnit ?? _currentPet!.weightUnit,
        dob: dob ?? _currentPet!.dob,
        gender: gender ?? _currentPet!.gender,
        extraDetails: extraDetails ?? _currentPet!.extraDetails,
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
