
import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  void setUser(UserModel? user) {
    _user = user;
    print("user updated");
    notifyListeners();
  }

  void updateAddress(AddressModel address) {
    if (_user != null) {
      _user = UserModel(
        id: _user!.id,
        displayName: _user!.displayName,
        email: _user!.email,
        photoUrl: _user!.photoUrl,
        address: address,
      );
      notifyListeners();
    }
  }

  bool hasAddress() {
    return _user?.address != null;
  }
}
