import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ploofypaws/pages/home/services/pet_diet.dart';

class SelectionState {
  final bool isNonVegSelected;
  final bool isVegSelected;

  SelectionState({required this.isNonVegSelected, required this.isVegSelected});
}

class SelectionNotifier with ChangeNotifier {
  SelectionState _state = SelectionState(isNonVegSelected: true, isVegSelected: true);

  SelectionState get state => _state;

  void toggleNonVeg() {
    _state = SelectionState(
      isNonVegSelected: !_state.isNonVegSelected,
      isVegSelected: _state.isVegSelected,
    );
    notifyListeners();
  }

  void toggleVeg() {
    _state = SelectionState(
      isNonVegSelected: _state.isNonVegSelected,
      isVegSelected: !_state.isVegSelected,
    );
    notifyListeners();
  }
}
