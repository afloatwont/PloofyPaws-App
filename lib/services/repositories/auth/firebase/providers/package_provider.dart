import 'package:flutter/material.dart';

class Package {
  String name;
  int price;
  List<String> content;
  DateTime? time;

  Package({
    required this.name,
    required this.price,
    required this.content,
     this.time,
  });
}

// PackageProvider class
class PackageProvider with ChangeNotifier {
  Package? _package;

  Package? get package => _package;

  void setPackage(Package? package) {
    _package = package;
    notifyListeners();
  }

  void removePackage() {
    _package = null;
    notifyListeners();
  }
}