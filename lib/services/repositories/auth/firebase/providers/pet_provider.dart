import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class PetProvider with ChangeNotifier {
  List<Pet>? _pets = [];
  Pet? _currentPet;
  final _getIt = GetIt.instance;
  List<Pet>? get pets => _pets;
  Pet? get currentPet => _currentPet;

  void startAddingPet() {
    _currentPet = Pet(
      name: '',
      description: '',
      ownerId: '',
      characteristics: [],
      aggression: '',
      diet: '',
      type: "dog", // default value
      breeds: '',
      weight: '0',
      weightUnit: "Kg", // default value
      dob: DateTime.now(),
      gender: 'Not Specified', // default value
      extraDetails: [],
    );
    notifyListeners();
  }

  void setPets(List<Pet>? petss) {
    _pets = petss;
    _currentPet = _pets?[0];
    print("pets set");
    notifyListeners();
  }

  Future<void> update(String userid) async {
    final dbService = _getIt.get<UserDatabaseService>();
    _pets = await dbService.getAllPetsForUser(userid);
    notifyListeners();
  }

  void clear() {
    _pets = null;
    _currentPet = null;
    notifyListeners();
  }

  void setCurrentPet(Pet? newpet) {
    _currentPet = newpet;
    print("Pet Selected");
    notifyListeners();
  }

  void updatePet({
    String? name,
    String? ownerId,
    String? description,
    List<String>? characteristics,
    String? aggression,
    String? diet,
    String? type,
    String? breeds,
    String? weight,
    String? weightUnit,
    DateTime? dob,
    String? gender,
    List<String>? extraDetails,
  }) {
    if (_currentPet != null) {
      _currentPet = Pet(
        name: name ?? _currentPet!.name,
        description: description ?? _currentPet!.description,
        ownerId: ownerId,
        characteristics: characteristics ?? _currentPet!.characteristics,
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
      _pets!.add(_currentPet!);
      _currentPet = null;
      notifyListeners();
    }
  }
}
