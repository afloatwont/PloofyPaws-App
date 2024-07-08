import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class UserModel {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final AddressModel? address;
  final List<Pet>? pets;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.address,
    this.pets,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      address: json['address'] != null
          ? AddressModel.fromJson(json['address'] as Map<String, dynamic>)
          : null,
      pets: json['pets'] != null
          ? List<Pet>.from(json['pets'].map((petJson) => Pet.fromJson(petJson)))
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'address': address?.toJson(),
      'pets': pets?.map((pet) => pet.toJson()).toList(),
    };
  }
}
