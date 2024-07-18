import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ploofypaws/services/alert/alert_service.dart';
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
  CollectionReference? _petsCollection;

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

    _petsCollection = _firebaseFirestore.collection('pets').withConverter<Pet>(
          fromFirestore: (snapshots, _) => Pet.fromJson(snapshots.data()!),
          toFirestore: (pet, _) => pet.toJson(),
        );
  }

// ======================= USER ======================== //

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

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      // Check if email exists in Firebase Authentication
      List<String> signInMethods =
          await _authService.authIns.fetchSignInMethodsForEmail(email);
      if (signInMethods.isNotEmpty) {
        return true; // Email exists in authentication
      }

      // Check if email exists in Firestore database
      QuerySnapshot userQuery =
          await _usersCollection!.where('email', isEqualTo: email).get();
      if (userQuery.docs.isNotEmpty) {
        return true; // Email exists in Firestore
      }

      return false; // Email does not exist in both authentication and Firestore
    } catch (e) {
      print(e);
      return Future.error('Error checking email existence');
    }
  }

// ================= ADDRESS ================== //

  Future<void> updateAddress(String uid, AddressModel address) async {
    print(address.toJson());
    final userDoc = _usersCollection!.doc(uid);
    await userDoc.update({
      'address': address.toJson(), // Nesting the address fields under 'address'
    });
    print("Address saved to cloud");
  }

// ==================== PETS ================== //

  Future<bool> doesPetExistForUser(String userId, Pet pet) async {
    QuerySnapshot querySnapshot = await _petsCollection!
        .where('ownerId', isEqualTo: userId)
        .where('name', isEqualTo: pet.name)
        .where('breeds', isEqualTo: pet.breeds)
        .where('dob', isEqualTo: pet.dob.toString())
        .where('type', isEqualTo: pet.type)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Add a new pet to the pets collection and link it to the user by ownerId
  Future<void> addPetToUser(String userId, Pet pet) async {
    bool petExists = await doesPetExistForUser(userId, pet);

    if (!petExists) {
      await _petsCollection?.add(pet);
      print("Pet added to database");
    } else {
      AlertService().showToast(text: "Pet already exists!");
      print("Pet already exists for this user");
    }
  }

  // Update an existing pet's details in the pets collection
  Future<void> updatePetForUser(String petId, Pet updatedPet) async {
    DocumentReference petDoc = _petsCollection!.doc(petId);
    await petDoc.update(updatedPet.toJson());
    print("Pet $petId updated");
  }

  // Retrieve all pets for a specific user
  Future<List<Pet>> getAllPetsForUser(String userId) async {
    QuerySnapshot querySnapshot =
        await _petsCollection!.where('ownerId', isEqualTo: userId).get();
    print(querySnapshot.docs.first.runtimeType);
    return querySnapshot.docs.map((doc) => doc.data() as Pet).toList();
    // return Pet.fromJson(querySnapshot.docs as Map<String, dynamic>);
  }

  // Delete a pet from the pets collection
  Future<void> deletePetFromUser(String petId) async {
    DocumentReference petDoc = _petsCollection!.doc(petId);
    await petDoc.delete();
    print("Pet $petId deleted");
  }

  // When a user is deleted, delete their associated pets
  Future<void> deleteUserAndPets(String userId) async {
    // Delete user
    DocumentReference userDoc = _usersCollection!.doc(userId);
    await userDoc.delete();

    // Delete associated pets
    QuerySnapshot petSnapshot =
        await _petsCollection!.where('ownerId', isEqualTo: userId).get();

    WriteBatch batch = _firebaseFirestore.batch();

    for (DocumentSnapshot doc in petSnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
    print("User $userId and associated pets deleted");
  }
}
