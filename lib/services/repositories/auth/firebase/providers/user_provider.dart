import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_store.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  UserModel? get user => _user;
  AddressModel? selectedAddress;
  UserProvider() {
    selectedAddress = user?.address?.first;
  }

  void setUser(UserModel? user) {
    _user = user;
    print("user updated");
    notifyListeners();
  }

  void selectAddress(AddressModel? address) {
    selectedAddress = address;
    print("selected address: ${address?.flatNo}");
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> update(String userId) async {
    final databaseService = GetIt.instance.get<UserDatabaseService>();
    final user = await databaseService.getUserProfileByUID(userId);
    _user = user;
    notifyListeners();
  }

  void updateAddress(AddressModel address) {
    if (_user != null) {
      _user!.address!.add(address);
      notifyListeners();
    }
  }

  bool hasAddress() {
    return _user?.address?.isNotEmpty ?? false;
  }
}
