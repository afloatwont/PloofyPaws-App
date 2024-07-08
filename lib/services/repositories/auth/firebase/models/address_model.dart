
import 'package:flutter/material.dart';

class AddressModel with ChangeNotifier {
  String? flatNo;
  String? area;
  String? landmark;
  bool? isForMyself;
  String? saveAs;

  AddressModel({
    this.flatNo = '',
    this.area = '',
    this.landmark = '',
    this.isForMyself = true,
    this.saveAs = 'Home',
  });

  // Converts a JSON map to an AddressModel instance
  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      flatNo: json['flatNo'] as String? ?? '',
      area: json['area'] as String? ?? '',
      landmark: json['landmark'] as String? ?? '',
      isForMyself: json['isForMyself'] as bool? ?? true,
      saveAs: json['saveAs'] as String? ?? 'Home',
    );
  }

  // Converts an AddressModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'flatNo': flatNo,
      'area': area,
      'landmark': landmark,
      'isForMyself': isForMyself,
      'saveAs': saveAs,
    };
  }

  void updateFlatNo(String value) {
    flatNo = value;
    notifyListeners();
  }

  void updateArea(String value) {
    area = value;
    notifyListeners();
  }

  void updateLandmark(String value) {
    landmark = value;
    notifyListeners();
  }

  void updateIsForMyself(bool value) {
    isForMyself = value;
    notifyListeners();
  }

  void updateSaveAs(String value) {
    saveAs = value;
    notifyListeners();
  }
}