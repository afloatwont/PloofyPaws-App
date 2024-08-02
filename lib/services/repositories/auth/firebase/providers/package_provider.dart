import 'package:flutter/material.dart';

class Package {
  String? name;
  int? price;
  List<String>? content;
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

  void setName(String name) {
    _package?.name = name;
    notifyListeners();
  }

  void setPrice(int price) {
    _package?.price = price;
    notifyListeners();
  }

  void setContent(List<String> content) {
    _package?.content = content;
    notifyListeners();
  }

  void setTime(DateTime time) {
    _package?.time = time;
    notifyListeners();
  }

  void removePackage() {
    _package = null;
    notifyListeners();
  }
}
