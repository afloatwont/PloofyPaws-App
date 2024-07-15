import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/fire_auth.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/address_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/user_model.dart';
import 'package:ploofypaws/services/repositories/auth/firebase/models/pet_model.dart';

class UserDatabaseService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final GetIt _getIt = GetIt.instance;
  late AuthServices _authService;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
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
    print("User added to database");
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

  Future<String> uploadProfilePicture(String userId, File file) async {
    try {
      // Create a reference to the location you want to upload to in Firebase Storage
      Reference storageReference = _firebaseStorage
          .ref()
          .child('pfp/$userId/${file.uri.pathSegments.last}');

      // Upload the file
      UploadTask uploadTask = storageReference.putFile(file);

      // Waits till the file is uploaded then stores the download url
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update the user profile with the download URL
      await _usersCollection?.doc(userId).update({'photoUrl': downloadUrl});
      final userDoc = _usersCollection!.doc(userId);
      await userDoc.update({
        'photoUrl': downloadUrl, // Nesting the address fields under 'address'
      });

      return downloadUrl;
    } catch (e) {
      print(e);
      return Future.error('Error uploading profile picture');
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

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      // Check if email exists in Firebase Authentication
      List<String> signInMethods = await _authService.authIns.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        return true; // Email exists in authentication
      }

      // Check if email exists in Firestore database
      QuerySnapshot userQuery = await _usersCollection!.where('email', isEqualTo: email).get();
      if (userQuery.docs.isNotEmpty) {
        return true; // Email exists in Firestore
      }

      return false; // Email does not exist in both authentication and Firestore
    } catch (e) {
      print(e);
      return Future.error('Error checking email existence');
    }
  }
}
