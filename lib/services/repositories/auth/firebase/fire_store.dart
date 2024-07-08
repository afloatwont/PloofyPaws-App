import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class UserDatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authService;

  CollectionReference? _usersCollection;

  UserDatabaseService() {
    setupCollectionReferences();
    _authService = _getIt.get<AuthServices>();
  }

  void setupCollectionReferences() {
    _usersCollection =
        _firebaseFirestore.collection('users').withConverter<UserModel>(
              fromFirestore: (snapshots, _) =>
                  UserModel.fromJson(snapshots.data()!),
              toFirestore: (userprofile, _) => userprofile.toJson(),
            );
  }

  Future<void> createUserProfile({
    required UserModel userProfile,
  }) async {
    await _usersCollection?.doc(userProfile.id).set(userProfile);
  }

  Future<UserModel?> getUserProfileByUID(String uid) async {
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (docSnapshot.exists) {
      return UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } else {
      return null;
    }
  }

  Future<void> updateAddress(String uid, AddressModel address) async {
    print(address.toJson());
    final userDoc = _usersCollection!.doc(uid);
    await userDoc.update({
      'address': address.toJson(), // Nesting the address fields under 'address'
    });
    print("Address saved to cloud");
  }

  Future<void> addPetToUser(String userId, Pet pet) async {
    DocumentReference userDoc = _usersCollection!.doc(userId);
    await userDoc.update({
      'pets': FieldValue.arrayUnion([pet.toJson()]),
    });
  }

  Future<void> updatePetForUser(String userId, Pet updatedPet) async {
    DocumentReference userDoc = _usersCollection!.doc(userId);
    DocumentSnapshot docSnapshot = await userDoc.get();

    try {
      if (docSnapshot.exists) {
        UserModel user = (docSnapshot.data() as UserModel);
        List<Pet>? pets =
            user.pets ?? []; // Initialize with an empty list if pets is null

        int petIndex = pets.indexWhere((pet) => pet.name == updatedPet.name);
        if (petIndex != -1) {
          pets[petIndex] = updatedPet;
        } else {
          pets.add(updatedPet);
        }

        await userDoc.update({
          'pets': pets.map((pet) => pet.toJson()).toList(),
        });
        print("Pet added");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<Pet>> getAllPetsForUser(String userId) async {
    DocumentSnapshot docSnapshot = await _usersCollection!.doc(userId).get();

    if (docSnapshot.exists) {
      UserModel user = docSnapshot.data() as UserModel;
      return user.pets ?? [];
    } else {
      return [];
    }
  }

  Future<void> deletePetFromUser(String userId, String petName) async {
    DocumentReference userDoc = _usersCollection!.doc(userId);
    DocumentSnapshot docSnapshot = await userDoc.get();

    if (docSnapshot.exists) {
      UserModel user =
          UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      List<Pet>? pets = user.pets;

      if (pets != null) {
        pets.removeWhere((pet) => pet.name == petName);
        await userDoc.update({
          'pets': pets.map((pet) => pet.toJson()).toList(),
        });
      }
    }
  }
}
