import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';

class UserModel {
  final String? id;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final List<AddressModel>? address;

  UserModel({
    required this.id,
    required this.displayName,
    required this.email,
    required this.photoUrl,
    this.address,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photoUrl'] as String?,
      address: (json['address'] as List<dynamic>?)
          ?.map((e) => AddressModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'address': address?.map((e) => e.toJson()).toList(),
    };
  }
}
