import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restoe/pages/home/services/pet_diet.dart';

final selectionProvider =
    StateNotifierProvider<SelectionNotifier, SelectionState>((ref) {
  return SelectionNotifier();
});

class SelectionState {
  final bool isNonVegSelected;
  final bool isVegSelected;

  SelectionState({required this.isNonVegSelected, required this.isVegSelected});
}

class SelectionNotifier extends StateNotifier<SelectionState> {
  SelectionNotifier()
      : super(SelectionState(isNonVegSelected: true, isVegSelected: true));

  void toggleNonVeg() {
    state = SelectionState(
      isNonVegSelected: !state.isNonVegSelected,
      isVegSelected: state.isVegSelected,
    );
  }

  void toggleVeg() {
    state = SelectionState(
      isNonVegSelected: state.isNonVegSelected,
      isVegSelected: !state.isVegSelected,
    );
  }
}