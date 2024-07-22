import 'package:flutter/material.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/doctor_model.dart';

class VeterinaryDoctorProvider with ChangeNotifier {
  VeterinaryDoctor? _doctor;

  VeterinaryDoctor? get doctor => _doctor;

  void setDoctor(VeterinaryDoctor? doctor) {
    _doctor = doctor;
    notifyListeners();
  }

  void updateDoctor({
    String? name,
    String? position,
    int? experience,
    String? specialization,
    String? contactInfo,
  }) {
    if (_doctor != null) {
      _doctor = VeterinaryDoctor(
        name: name ?? _doctor!.name,
        position: position ?? _doctor!.position,
        experience: experience ?? _doctor!.experience,
        specialization: specialization ?? _doctor!.specialization,
        contactInfo: contactInfo ?? _doctor!.contactInfo,
      );
      notifyListeners();
    }
  }
}
